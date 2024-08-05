import 'package:flutter/material.dart';
import 'package:stal/services/places_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddressSearch extends SearchDelegate<Suggestion> {
  AddressSearch(this.sessionToken) {
    apiClient = PlaceApiProvider(sessionToken);
  }

  final sessionToken;
  late PlaceApiProvider apiClient;

  String _streetNumber = '';
  String _street = '';
  String _city = '';
  String _zipCode = '';

  final TextEditingController _controller = TextEditingController();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear, color: Colors.black),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        close(context, Suggestion(
          placeId: '',
          description: '',
        ));
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(
      child: Text(
        'No results found',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        child: const Text(
          'Enter your address',
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      return FutureBuilder<List<Suggestion>>(
        future: apiClient.fetchSuggestions(
          query,
          Localizations.localeOf(context).languageCode,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.black),
            ));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(
              'No results found for "$query"',
              style: const TextStyle(color: Colors.black),
            ));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  snapshot.data![index].description,
                  style: const TextStyle(color: Colors.black),
                ),
                onTap: () async {
                  final selectedSuggestion = snapshot.data![index];
                  final placeDetails = await apiClient.getPlaceDetailFromId(selectedSuggestion.placeId);

                  _streetNumber = placeDetails.streetNumber;
                  _street = placeDetails.street;
                  _city = placeDetails.city;
                  _zipCode = placeDetails.zipCode;
                  _controller.text = _getFormattedAddress();

                  close(context, selectedSuggestion);

                  showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: const Text('Selected Address'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 20.0),
                                _buildFieldOption(
                                  context,
                                  title: 'Street Number',
                                  value: _streetNumber,
                                  onPressed: () async {
                                    String? newValue = await _editField(context, 'streetNumber');
                                    if (newValue != null && newValue.isNotEmpty) {
                                      setState(() {
                                        _streetNumber = newValue;
                                        _controller.text = _getFormattedAddress();
                                      });
                                    }
                                  },
                                ),
                                _buildFieldOption(
                                  context,
                                  title: 'Street',
                                  value: _street,
                                  onPressed: () async {
                                    String? newValue = await _editField(context, 'street');
                                    if (newValue != null && newValue.isNotEmpty) {
                                      setState(() {
                                        _street = newValue;
                                        _controller.text = _getFormattedAddress();
                                      });
                                    }
                                  },
                                ),
                                _buildFieldOption(
                                  context,
                                  title: 'City',
                                  value: _city,
                                  onPressed: () async {
                                    String? newValue = await _editField(context, 'city');
                                    if (newValue != null && newValue.isNotEmpty) {
                                      setState(() {
                                        _city = newValue;
                                        _controller.text = _getFormattedAddress();
                                      });
                                    }
                                  },
                                ),
                                _buildFieldOption(
                                  context,
                                  title: 'ZIP Code',
                                  value: _zipCode,
                                  onPressed: () async {
                                    String? newValue = await _editField(context, 'zipCode');
                                    if (newValue != null && newValue.isNotEmpty) {
                                      setState(() {
                                        _zipCode = newValue;
                                        _controller.text = _getFormattedAddress();
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  if (_validateAddress()) {
                                    await _saveAddressToFirebase();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Address saved successfully')),
                                    );
                                    Navigator.of(context).pop();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Invalid address format')),
                                    );
                                  }
                                },
                                child: const Text('Save'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            );
          }
        },
      );
    }
  }

  Widget _buildFieldOption(
      BuildContext context, {
        required String title,
        required String value,
        required VoidCallback onPressed,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$title: $value',
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'Edit',
            style: TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }

  Future<String?> _editField(BuildContext context, String field) async {
    return await showDialog<String>(
      context: context,
      builder: (context) {
        String currentValue = '';
        switch (field) {
          case 'streetNumber':
            currentValue = _streetNumber;
            break;
          case 'street':
            currentValue = _street;
            break;
          case 'city':
            currentValue = _city;
            break;
          case 'zipCode':
            currentValue = _zipCode;
            break;
        }
        TextEditingController controller = TextEditingController(text: currentValue);
        return AlertDialog(
          title: Text('Edit $field'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: 'Enter new $field',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(controller.text);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }


  Future<void> _saveAddressToFirebase() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null && _validateAddress()) {
      DocumentReference userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);

      // Check if location already exists
      DocumentSnapshot doc = await userDoc.get();
      if (doc.exists) {
        await userDoc.update({
          'location': _controller.text,
        });
      } else {
        await userDoc.set({
          'location': _controller.text,
        });
      }
    }
  }

  bool _validateAddress() {
    // Validate ZIP code format (example: 41-103)
    final zipCodePattern = RegExp(r'^\d{2}-\d{3}$');
    if (_street.isEmpty || _city.isEmpty || !zipCodePattern.hasMatch(_zipCode)) {
      return false;
    }
    return true;
  }

  String _getFormattedAddress() {
    // Format the address based on the updated fields
    if (_streetNumber.isEmpty) {
      return '$_street, $_city, $_zipCode';
    } else {
      return '$_streetNumber $_street, $_city, $_zipCode';
    }
  }
}
