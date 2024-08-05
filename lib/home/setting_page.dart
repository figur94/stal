import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stal/main.dart'; // Ensure this import is correct
import 'package:stal/services/address_search.dart';
import 'package:stal/services/places_service.dart';
import 'package:uuid/uuid.dart'; // For generating session token

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String? _fullName;
  File? _imageFile;
  String? _profilePictureUrl;

  // Variables for address details
  String? _savedAddress;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _nameController.text = _user?.displayName ?? '';
    _fullName = _user?.displayName;
    _loadProfilePictureUrl();
    _loadAddressFromFirebase();
  }

  Future<void> _loadProfilePictureUrl() async {
    if (_user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            _profilePictureUrl = userDoc.get('profilePicture') as String?;
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print('Failed to load profile picture URL: $e');
        }
      }
    }
  }

  Future<void> _loadAddressFromFirebase() async {
    if (_user != null) {
      try {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(_user!.uid)
            .get();

        if (userDoc.exists) {
          setState(() {
            _savedAddress = userDoc.get('location') as String?;
            _addressController.text = _savedAddress ?? '';
          });
        }
      } catch (e) {
        if (kDebugMode) {
          print('Failed to load address: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moje dane'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _selectImage();
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _profilePictureUrl != null
                      ? NetworkImage(_profilePictureUrl!)
                      : (_imageFile != null ? FileImage(_imageFile!) : null),
                  child: _imageFile == null && _profilePictureUrl == null
                      ? Icon(Icons.camera_alt, size: 50, color: Colors.grey[800])
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              _fullName != null
                  ? Column(
                children: [
                  Row(
                    children: [
                      Text('Nazwa: $_fullName'),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _fullName = null;
                          });
                        },
                        child: const Text('Edit'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Email: ${_user?.email ?? "No email available"}',
                  ),
                ],
              )
                  : Column(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Imie i Nazwisko',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      saveNameToFirebase(_nameController.text.trim());
                    },
                    child: const Text('Save Name'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _savedAddress != null
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Adres: $_savedAddress',
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _savedAddress = null;
                        _addressController.text = '';
                      });
                    },
                    child: const Text('Edit'),
                  ),
                ],
              )
                  : TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.home, color: Color.fromRGBO(249, 255, 251, 1.0)),
                  hintText: "Podaj adres dostawy ...",
                ),
                readOnly: true,
                onTap: () async {
                  final sessionToken = const Uuid().v4();
                  final Suggestion? result = await showSearch(
                    context: context,
                    delegate: AddressSearch(sessionToken),
                  );
                  if (result != null) {
                    setState(() {
                      _addressController.text = result.description;
                      _savedAddress = _addressController.text;
                    });

                    // Update address in Firebase
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(_user!.uid)
                        .update({'location': _savedAddress});
                    _loadAddressFromFirebase();
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text('Logout'),
              ),
            ],
          ),
        ),
    );
  }

  void saveNameToFirebase(String name) async {
    bool success = false;

    try {
      await _user?.updateDisplayName(name);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(_user?.uid)
          .update({'fullName': name});

      setState(() {
        _fullName = name;
      });

      success = true;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to update name: $e');
      }
    } finally {
      // Use WidgetsBinding to ensure the context is still valid
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Name updated successfully')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update name')),
          );
        }
      });
    }
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      String userId = _user!.uid;
      String fileName = 'profile_picture.jpg';

      Reference storageRef = FirebaseStorage.instance.ref().child('users').child(userId).child(fileName);

      bool success = false;
      try {
        await storageRef.putFile(_imageFile!);
        String downloadURL = await storageRef.getDownloadURL();

        // Update Firestore with the download URL of the image
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'profilePicture': downloadURL});

        // Update the profile picture URL in the state
        setState(() {
          _profilePictureUrl = downloadURL;
        });

        success = true;
      } catch (e) {
        if (kDebugMode) {
          print('Failed to upload image to Firebase Storage: $e');
        }
      } finally {
        // Use WidgetsBinding to ensure the context is still valid
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile picture updated successfully')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed to update profile picture')),
            );
          }
        });
      }
    } else {
      if (kDebugMode) {
        print('No image selected.');
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose(); // Dispose address controller
    super.dispose();
  }
}
