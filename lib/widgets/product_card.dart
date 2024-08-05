import 'package:flutter/material.dart';
import 'package:stal/models/products_models.dart';

class ProductCard extends StatelessWidget {
  final Products product;
  final TextEditingController weightController;
  final TextEditingController lengthController;
  final TextEditingController priceController;
  final Function(Products, double, double) onAdd;

  const ProductCard({
    required this.product,
    required this.weightController,
    required this.lengthController,
    required this.priceController,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: Text(
                  product.name,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              Flexible(
                flex: 2,
                child: TextFormField(
                  controller: weightController,
                  decoration: const InputDecoration(
                    hintText: '0.0 kg',
                    contentPadding: EdgeInsets.all(4.0),
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 14),
                  onChanged: (value) {
                    double? parsedValue = double.tryParse(value);
                    if (parsedValue == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid number'),
                        ),
                      );
                    }
                  },
                ),
              ),
              Flexible(
                flex: 2,
                child: TextFormField(
                  controller: lengthController,
                  decoration: const InputDecoration(
                    hintText: '0.0 m',
                    contentPadding: EdgeInsets.all(4.0),
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 14),
                  onChanged: (value) {
                    double? parsedValue = double.tryParse(value);
                    if (parsedValue == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid number'),
                        ),
                      );
                    }
                  },
                ),
              ),
              Flexible(
                flex: 2,
                child: TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    hintText: '0.0 PLN',
                    contentPadding: EdgeInsets.all(4.0),
                  ),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(fontSize: 14),
                  onChanged: (value) {
                    double? parsedValue = double.tryParse(value);
                    if (parsedValue == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please enter a valid number'),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.add_shopping_cart),
            onPressed: () {
              double? weight = double.tryParse(weightController.text);
              double? length = double.tryParse(lengthController.text);
              double? price = double.tryParse(priceController.text);
              if (weight != null && length != null && price != null) {
                onAdd(product, weight, length);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter valid weight, length, and price'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
