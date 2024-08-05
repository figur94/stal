import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stal/models/products_models.dart';
import 'package:stal/constants/constants.dart';
import 'package:stal/firestore_service.dart';
import 'package:stal/widgets/header_delegate.dart';


class MyProductsPage extends StatefulWidget {
  const MyProductsPage({super.key});

  @override
  MyProductsPageState createState() => MyProductsPageState();
}

class MyProductsPageState extends State<MyProductsPage> {
  final TextEditingController _textEditingController = TextEditingController();
  List<Products> userProducts = [];
  final FirestoreService _firestoreService = FirestoreService();
  String searchText = '';
  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onSearchTextChanged);
    _fetchUserProducts();
  }

  @override
  void dispose() {
    _textEditingController.removeListener(_onSearchTextChanged);
    _textEditingController.dispose();
    super.dispose();
  }

  void _onSearchTextChanged() {
    setState(() {
      searchText = _textEditingController.text;
    });
  }

  Future<void> _fetchUserProducts() async {
    final products = await _firestoreService.fetchUserProducts();
    setState(() {
      userProducts = products;
    });
  }

  Future<void> _updateProduct(Products product) async {
    await _firestoreService.updateProduct(product);
    await _fetchUserProducts();
  }

  Future<void> _deleteProduct(Products product) async {
    await _firestoreService.deleteProduct(product.id); // Implement this method in FirestoreService
    await _fetchUserProducts();
  }

  Future<void> _showDeleteConfirmationDialog(Products product) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () async {
                Navigator.of(context).pop(); // Dismiss the dialog
                await _deleteProduct(product);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(categoryIcons.length, (index) {
              return IconButton(
                icon: Icon(categoryIcons[index]),
                onPressed: () {
                  setState(() {
                    selectedCategoryIndex = index;
                  });
                },
                color:
                selectedCategoryIndex == index ? Colors.black : Colors.grey,
              );
            }),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: "Szukaj produktów",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchText.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _textEditingController.clear();
                    _onSearchTextChanged();
                  },
                )
                    : null,
              ),
            ),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    List<Products> filteredProducts = filterItems(userProducts, selectedCategoryIndex, searchText, dwuteowniki, ceowniki);
    List<String> headerTitles = ['Name', 'Length', 'Weight', 'Price'];

    return filteredProducts.isEmpty
        ? const Center(child: Text('No products found.'))
        : Column(
      children: [
        HeaderDelegate(titles: headerTitles),
        Expanded(
          child: ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return Dismissible(
                key: Key(product.id), // Assuming `id` is a unique identifier
                direction: DismissDirection.endToStart,
                onDismissed: (direction) async {
                  await _showDeleteConfirmationDialog(product);
                },
                background: Container(
                  color: Colors.red,
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              product.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextFormField(
                              initialValue: product.length.toString(),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(4.0)),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                product.length =
                                    double.tryParse(value) ?? product.length;
                                _updateProduct(product);
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0.0),
                            child: TextFormField(
                              initialValue: product.weight.toString(),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(4.0)),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                product.weight =
                                    double.tryParse(value) ?? product.weight;
                                _updateProduct(product);
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              initialValue: product.price.toString(),
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.all(4.0)),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                product.price =
                                    double.tryParse(value) ?? product.price;
                                _updateProduct(product);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
