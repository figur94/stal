import 'package:flutter/material.dart';

class SummaryPage extends StatelessWidget {
  final double totalWeight;
  final double totalPrice;
  final double totalTransportCost;
  final double totalCost;

  const SummaryPage({
    super.key,
    required this.totalWeight,
    required this.totalPrice,
    required this.totalTransportCost,
  }) : totalCost = totalPrice + totalTransportCost;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Weight: $totalWeight kg'),
            Text('Total Price: \$${totalPrice.toStringAsFixed(2)}'),
            Text('Total Transport Cost: \$${totalTransportCost.toStringAsFixed(2)}'),
            Text('Total Cost: \$${totalCost.toStringAsFixed(2)}'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement the buy functionality
                // For now, just navigate back
                Navigator.pop(context);
              },
              child: Text('Buy These Products'),
            ),
          ],
        ),
      ),
    );
  }
}
