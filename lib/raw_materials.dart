
class RawMaterial {
  String name;
  double length;
  double tempKgs; // Temporary kilograms added by the user, default 0.0
  double price; // Added to hold the product price, default 0.0

  RawMaterial({
    required this.name,
    required this.length,
    this.tempKgs = 0.0,
    this.price = 0.0,
  });
}

// class RawMaterialService {
//   Future<List<RawMaterial>> fetchRawMaterialsFromFirestore() async {
//     List<RawMaterial> rawMaterials = [];
//
//     try {
//       QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('raw_materials').get();
//
//       for (var doc in snapshot.docs) {
//         var data = doc.data();
//         rawMaterials.add(
//           RawMaterial(
//             name: data['name'],
//             length: data['length'].toDouble(), // Ensure this is a double
//             price: data['price'].toDouble(), // Ensure this is a double, assumes Firestore stores prices as numbers
//           ),
//         );
//       }
//     } catch (e) {
//       print('Error fetching raw materials: $e');
//     }
//
//     return rawMaterials;
//   }
// }
