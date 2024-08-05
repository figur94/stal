import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stal/purchases/summary_page.dart'; // Import the summary page
import '../models/rawmaterial_models.dart';

class ProductList extends StatefulWidget {
  final List<RawMaterial> cartItems;
  final List<double> enteredWeights;
  final List<double> enteredLengths;
  final String location;

  const ProductList({super.key, required this.cartItems, required this.enteredWeights, required this.location, required this.enteredLengths});

  @override
  ProductListState createState() => ProductListState();
}

class ProductListState extends State<ProductList> {
  late List<Product> _products;
  late Map<String, double> _distances;
  bool _sortByPrice = true;

  @override
  void initState() {
    super.initState();
    debugPrint("InitState called");
    _products = [];
    _distances = {};
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // Fetch Products
      QuerySnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('products').get();
      List<Product> products = productSnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return Product(
          location: data['location'] ?? '',
          name: data['name'],
          length: double.tryParse(data['length'].toString()) ?? 0.0,
          price: double.tryParse(data['price'].toString()) ?? 0.0,
          weight: double.tryParse(data['weight'].toString()) ?? 0.0,
          userId: data['userId'] ?? '',
        );
      }).toList();

      debugPrint("Fetched products: $products"); // Print fetched products

      setState(() {
        _products = products;
      });

      // Fetch route distances
      await _fetchRouteDistances();
    } catch (e) {
      debugPrint("Error fetching data: $e");
    }
  }


  Future<void> _fetchRouteDistances() async {
    const apiKey = 'AIzaSyAQ2FLvbwMnvfny2n2-rLzcyytkLbSG6XE'; // Replace with your Google Maps API key
    for (var product in _products) {
      final apiUrl = 'https://maps.googleapis.com/maps/api/directions/json?'
          'origin=${widget.location}&destination=${product
          .location}&key=$apiKey';
      try {
        final response = await http.get(Uri.parse(apiUrl));
        final jsonData = json.decode(response.body);
        final routes = jsonData['routes'] as List<dynamic>;
        final route = routes.isNotEmpty ? routes[0] : null;
        if (route != null) {
          final legs = route['legs'] as List<dynamic>;
          final leg = legs.isNotEmpty ? legs[0] : null;
          if (leg != null) {
            final distance = leg['distance'];
            final distanceInKm = double.tryParse(
                distance['text'].split(' ')[0]) ?? 0.0;
            debugPrint("Fetched distance for product ${product
                .name}: $distanceInKm km"); // Print distance

            setState(() {
              _distances['${product.userId}_${product.name}_${product
                  .length}'] = distanceInKm;
            });
          }
        }
      } catch (e) {
        debugPrint('Error fetching route distance: $e');
      }
    }
  }


  double _calculateTotalCost(Product product, double weight) {
    final distance = _distances['${product.userId}_${product.name}_${product
        .length}'] ?? 0;
    return (product.price * weight) +
        (distance * 4); // Transport cost calculation
  }

  void _toggleSort() {
    setState(() {
      _sortByPrice = !_sortByPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Building widget with products: $_products and distances: $_distances");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Oferty'),
        actions: [
          IconButton(
            icon: Icon(_sortByPrice ? Icons.monetization_on : Icons.directions),
            onPressed: _toggleSort,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (context, index) {
          final item = widget.cartItems[index];
          final weight = widget.enteredWeights[index];
          final length = widget.enteredLengths[index];

          // Debug print to verify data
          debugPrint("Cart item: $item, weight: $weight, length: $length");

          // Ensure length is properly used in comparison
          final matchingProducts = _products.where((product) {
            final matchesName = product.name == item.name;
            final matchesLength = product.length == length;
            debugPrint("Checking product: $product, matchesName: $matchesName, matchesLength: $matchesLength");
            return matchesName && matchesLength;
          }).toList();

          if (matchingProducts.isEmpty) {
            return const SizedBox.shrink();
          }

          // Sorting logic based on user preference
          if (_sortByPrice) {
            matchingProducts.sort((a, b) {
              return _calculateTotalCost(a, weight).compareTo(_calculateTotalCost(b, weight));
            });
          } else {
            matchingProducts.sort((a, b) {
              final distanceA = _distances['${a.userId}_${a.name}_${a.length}'] ?? double.infinity;
              final distanceB = _distances['${b.userId}_${b.name}_${b.length}'] ?? double.infinity;
              return distanceA.compareTo(distanceB);
            });
          }

          final bestProduct = matchingProducts.first;

          // Debug print to verify the selected product details
          debugPrint("Displaying product: ${bestProduct.name}, Total cost: ${_calculateTotalCost(bestProduct, weight)}, Distance: ${_distances['${bestProduct.userId}_${bestProduct.name}_${bestProduct.length}']} km");

          return ListTile(
            title: Text(bestProduct.name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location: ${bestProduct.location}', style: Theme.of(context).textTheme.bodyLarge),
                Text('Length: ${bestProduct.length}', style: Theme.of(context).textTheme.bodyLarge),
                Text('Price: ${bestProduct.price}', style: Theme.of(context).textTheme.bodyLarge),
                Text('Weight: $weight', style: Theme.of(context).textTheme.bodyLarge),
                Text('Distance: ${_distances['${bestProduct.userId}_${bestProduct.name}_${bestProduct.length}']} km', style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
            trailing: const Icon(Icons.check_circle, color: Colors.green),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // FloatingActionButton logic here
        },
        child: const Icon(Icons.add),
      ),

    );
  }

}

  class Product {
  final String location;
  final double length;
  final String name;
  final double price;
  final double weight;
  final String userId;

  Product({
    required this.location,
    required this.length,
    required this.name,
    required this.price,
    required this.weight,
    required this.userId,
  });
  @override
  String toString() {
    return 'Product(name: $name, location: $location, length: $length)';
  }
}
