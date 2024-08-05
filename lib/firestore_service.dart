import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stal/models/products_models.dart';

class FirestoreService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Products>> fetchUserProducts() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final querySnapshot = await _firestore
            .collection('products')
            .where('userId', isEqualTo: user.uid)
            .get();

        return querySnapshot.docs.map((doc) {
          final data = doc.data();
          return Products(
            id: doc.id,
            name: data['name'],
            weight: (data['weight'] as num).toDouble(),
            length: (data['length'] as num).toDouble(),
            price: (data['price'] as num).toDouble(),
          );
        }).toList();
      } catch (e) {
        print('Error fetching user products: $e');
        return [];
      }
    }
    return [];
  }

  Future<void> updateProduct(Products product) async {
    try {
      await _firestore.collection('products').doc(product.id).update({
        'name': product.name,
        'weight': product.weight,
        'length': product.length,
        'price': product.price,
      });
      print('Product updated: ${product.name}');
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
      print('Product deleted with id: $productId');
    } catch (e) {
      print('Error deleting product: $e');
    }
  }
}
