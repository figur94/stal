import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';
import 'package:stal/services/saved_location_provider.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          return const CityDistancePage();
        } else {
          return SignInScreen();
        }
      },
    );
  }
}

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInScreen({super.key});

  void signIn(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign in. Please check your credentials.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => signIn(context),
              child: const Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}

class CityDistancePage extends StatefulWidget {
  const CityDistancePage({super.key});

  @override
  _CityDistancePageState createState() => _CityDistancePageState();
}

class _CityDistancePageState extends State<CityDistancePage> {
  final TextEditingController _cityPostalCodeController = TextEditingController();
  String _selectedCity = '';
  String _savedLocation = '';
  bool _isListViewEnabled = true;

  final GoogleMapsPlaces _places = GoogleMapsPlaces(
      apiKey: 'AIzaSyAQ2FLvbwMnvfny2n2-rLzcyytkLbSG6XE');

  List<Prediction> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _cityPostalCodeController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _cityPostalCodeController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    String query = _cityPostalCodeController.text;
    if (query.isNotEmpty) {
      _searchCities(query);
    } else {
      setState(() {
        _suggestions.clear();
      });
    }
  }

  Future<void> _searchCities(String query) async {
    try {
      PlacesAutocompleteResponse response = await _places.autocomplete(
        query,
        types: ['(regions)'],
      );
      if (response.isOkay) {
        setState(() {
          _suggestions = response.predictions;
          _isListViewEnabled = true; // Re-enable ListView
        });
      } else {
        setState(() {
          _suggestions.clear();
          _isListViewEnabled = false; // Disable ListView
        });
      }
    } catch (e) {
      setState(() {
        _suggestions.clear();
        _isListViewEnabled = false; // Disable ListView
      });
    }
  }

  void _saveLocation() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && _selectedCity.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).set({
          'savedLocation': _selectedCity,
          'timestamp': FieldValue.serverTimestamp(),  // Optionally store the time of saving the location
        }, SetOptions(merge: true));  // Use merge option to update data without overwriting existing data

        setState(() {
          _savedLocation = _selectedCity;
          final savedLocationProvider = Provider.of<SavedLocationProvider>(context, listen: false);
          savedLocationProvider.updateSavedLocation(_selectedCity);
          _suggestions.clear(); // Clear suggestions list
          _cityPostalCodeController.text = _selectedCity; // Set selected city in the text field
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location saved successfully')),
        );

      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save location: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('City Distance Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _cityPostalCodeController,
              decoration: const InputDecoration(
                labelText: 'Enter City and Postal Code',
                hintText: 'e.g. Katowice, Śląskie',
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _suggestions.isEmpty
                  ? const SizedBox.shrink()
                  : ListView.builder(
                itemCount: _suggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_suggestions[index].description ?? ''),
                    onTap: _isListViewEnabled
                        ? () {
                      setState(() {
                        _selectedCity =
                            _suggestions[index].description ?? '';
                      });
                    }
                        : null, // Disable onTap when ListView is disabled
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed:
              _isListViewEnabled ? _saveLocation : null, // Disable button when ListView is disabled
              child: const Text('Save Location'),
            ),
            const SizedBox(height: 20),
            Text(
              'Saved Location: $_savedLocation',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: signOut,
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
