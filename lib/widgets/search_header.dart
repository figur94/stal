import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  final TextEditingController controller;
  final String searchText;
  final VoidCallback onClearSearch;

  const SearchHeader({
    required this.controller,
    required this.searchText,
    required this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Szukaj produktów",
          prefixIcon: const Icon(Icons.search),
          suffixIcon: searchText.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.close),
            onPressed: onClearSearch,
          )
              : null,
        ),
      ),
    );
  }
}
