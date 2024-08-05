import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.grey[850]!, // Darker grey for primary color
  primaryColorDark: const Color.fromRGBO(99, 95, 92, 1.0), // Even darker variant of the primary color
  primaryColorLight: Colors.grey[300]!, // Lighter variant of the primary color
  canvasColor: Colors.grey[50]!, // Background color for larger parts of the app
  scaffoldBackgroundColor: const Color.fromRGBO(249, 255, 251, 1.0), // Background color for Scaffolds
  cardColor: const Color.fromRGBO(234, 234, 234, 1.0), // Background color of cards
  dividerColor: Colors.grey, // Color of dividers
  highlightColor: Colors.grey[400]!, // Color of ink splash when tapped
  splashColor: Colors.grey[200]!, // Color for selected rows
  unselectedWidgetColor: Colors.grey[400]!, // Color for widgets like unchecked checkboxes, radio buttons, etc.
  disabledColor: Colors.grey[200]!, // Color to indicate disabled widgets
  secondaryHeaderColor: Colors.grey[50]!, // Background color for sticky headers
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Colors.grey[300]!, // Background color for text selection
    cursorColor: Colors.grey[700]!, // Color of the cursor in text fields
    selectionHandleColor: Colors.grey[400]!, // Color of the handlers for text selection
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: const Color.fromRGBO(149, 167, 168, 1.0), // Background color of ElevatedButton
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.grey[850]!,
      side: BorderSide(color: Colors.grey[850]!), // Border color of OutlinedButton
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey[400]!; // Text color when the button is disabled
        }
        return Colors.grey[850]!; // Text color when the button is enabled
      }),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),
  ),
  appBarTheme: AppBarTheme(
    color: const Color.fromRGBO(249, 255, 251, 1.0), // Color of the app bar
    iconTheme: const IconThemeData(color: Color.fromRGBO(99, 95, 92, 1.0)), // Icon color
    actionsIconTheme: const IconThemeData(color: Color.fromRGBO(99, 95, 92, 1.0)),
    toolbarTextStyle: const TextTheme(
      titleLarge: TextStyle(color: Color.fromRGBO(99, 95, 92, 1.0), fontSize: 18.0), // Text style for app bar title
    ).bodyMedium,
    titleTextStyle: const TextTheme(
      titleLarge: TextStyle(color: Color.fromRGBO(99, 95, 92, 1.0), fontSize: 18.0), // Text style for app bar title
    ).titleLarge,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color.fromRGBO(249, 255, 251, 1.0), // Set your desired background color here
    selectedItemColor: Color.fromRGBO(149, 167, 168, 1.0), // Set your desired selected item color here
    unselectedItemColor: Color.fromRGBO(149, 167, 168, 1.0),   // Set your desired unselected item color here
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: const BorderSide(color: Color.fromRGBO(149, 167, 168, 0.50)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: const BorderSide(color: Color.fromRGBO(149, 167, 168, 0.50)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: const BorderSide(color: Color.fromRGBO(149, 167, 168, 0.50)),
    ),
    filled: true,
    fillColor: const Color.fromRGBO(149, 167, 168, 0.20),
    hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
  ),
  cardTheme: CardTheme(
    color: Color.fromRGBO(229, 237, 235, 1),
    margin: const EdgeInsets.symmetric(horizontal: 16.0),
    elevation: 4,
  ),
);
