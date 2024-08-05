import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:stal/screens/kalkulator_page.dart';
import 'package:stal/screens/purchase_page.dart';
import 'package:stal/screens/sales_page.dart';
import 'package:stal/screens/myproducts_page.dart';
import 'package:stal/home/setting_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String? _fullName = '';
  String? _profilePictureUrl;


  @override
  void initState() {
    super.initState();
    fetchFullName(); // Fetch initial fullName from Firestore
  }

  Future<void> fetchFullName() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
      setState(() {
        _fullName = userDoc['fullName']; // Update _fullName with the fullName from Firestore
        _profilePictureUrl = userDoc['profilePicture']; // Update _profilePictureUrl with the URL from Firestore
      });
    } catch (e) {
      if (kDebugMode) {
        print('Failed to fetch user data: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double buttonWidth = screenSize.width * 0.4; // Adjust this ratio as needed
    const double buttonHeight = 100.0; // Set a fixed height for the buttons

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Text('STAL - MARKET',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            )),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0), // Adjust padding as needed
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero, // Set this
                padding: const EdgeInsets.only(left: 0, right: 8),
                  shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0), // Set border radius for rounded corners
            ),
                  ),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
                fetchFullName(); // Update fullName after returning from SettingsPage
              },
                      child: Row(
                        children: [
                          if (_profilePictureUrl != null)
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0), // Space between avatar and text
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(_profilePictureUrl!),
                              ),
                            ),
                          Text(_fullName ?? 'Loading...'),
                          const SizedBox(width: 6.0),
                          const Icon(Icons.settings),

                        ],
                      ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First row of buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProductsPageList()),
                          );
                        },
                        child: const Text('Zakupy'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Adjust the spacing between buttons
                  Expanded(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SalesPage()),
                          );
                        },
                        child: const Text('Sprzedaż'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Adjust the vertical spacing between rows
              // Second row of buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MyProductsPage()),
                          );
                        },
                        child: const Text('Moje oferty'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Adjust the spacing between buttons
                  Expanded(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const KalkulatorPage()),
                          );
                        },
                        child: const Text('Kalkulator'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
