import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SavedLocationProvider with ChangeNotifier {
  String _savedLocation = "Default Location";

  String get savedLocation => _savedLocation;

  void updateSavedLocation(String newLocation) {
    _savedLocation = newLocation;
    notifyListeners();
    // You may also want to update the Firestore database here
    saveLocationToFirestore(newLocation);
  }

  Future<void> loadLocationFromFirestore(String userId) async {
    var document = await FirebaseFirestore.instance.collection('userLocations').doc(userId).get();
    if (document.exists) {
      _savedLocation = document.data()?['location'] ?? "No location set";
      notifyListeners();
    }
  }

  Future<void> saveLocationToFirestore(String location) async {
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    await FirebaseFirestore.instance.collection('userLocations').doc(userId).set({'location': location});
  }
}
