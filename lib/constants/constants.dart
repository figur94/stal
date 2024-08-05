import 'package:flutter/material.dart';
import 'package:stal/services/my_flutter_app_icons.dart';
import 'package:stal/models/products_models.dart';
import 'package:stal/models/rawmaterial_models.dart';

final List<String> dwuteowniki = [
  'IPE', 'IPN', 'HEA', 'HEB', 'HEC', 'HEM'
];

// List of ceowniki
final List<String> ceowniki = [
  'UPE', 'UPN'
];
int selectedCategoryIndex = 0;
String searchText = '';
// List of category icons
final List<IconData> categoryIcons = [
  Icons.all_inclusive, // All products (default)
  MyFlutterApp.bean, // Dwuteowniki
  MyFlutterApp.ceownik, // Ceowniki
  MyFlutterApp.katownik, // Sheets
  MyFlutterApp.blacha, // Pipes
  MyFlutterApp.profil, // Channels
  MyFlutterApp.rura, // Tubes
  MyFlutterApp.pret, // Bars
];
List<Products> filterItems(List<Products> userProducts, int selectedCategoryIndex, String searchText, List<String> dwuteowniki, List<String> ceowniki) {
  List<Products> filteredItems;

  switch (selectedCategoryIndex) {
    case 1:
      filteredItems = userProducts
          .where((material) => dwuteowniki.any((prefix) => material.name.startsWith(prefix)))
          .toList(); // I-Beams
      break;
    case 2:
      filteredItems = userProducts
          .where((material) => ceowniki.any((prefix) => material.name.startsWith(prefix)))
          .toList(); // Angles
      break;
    case 3:
      filteredItems = userProducts
          .where((material) => material.name.startsWith('SHEET'))
          .toList(); // Sheets
      break;
    case 4:
      filteredItems = userProducts
          .where((material) => material.name.startsWith('PIPE'))
          .toList(); // Pipes
      break;
    case 5:
      filteredItems = userProducts
          .where((material) => material.name.startsWith('C'))
          .toList(); // Channels
      break;
    case 6:
      filteredItems = userProducts
          .where((material) => material.name.startsWith('TUBE'))
          .toList(); // Tubes
      break;
    case 7:
      filteredItems = userProducts
          .where((material) => material.name.startsWith('BAR'))
          .toList(); // Bars
      break;
    case 8:
      filteredItems = userProducts
          .where((material) => material.name.startsWith('PLATE'))
          .toList(); // Plates
      break;
    default:
      filteredItems = userProducts; // All products
  }

  if (searchText.isNotEmpty) {
    filteredItems = filteredItems
        .where((material) => material.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  filteredItems.sort((a, b) => a.name.compareTo(b.name));
  return filteredItems;
}
