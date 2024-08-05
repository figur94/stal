import 'package:flutter/material.dart';

class PretyWeightCalculator extends StatefulWidget {
  const PretyWeightCalculator({super.key});

  @override
  _PretyWeightCalculatorState createState() => _PretyWeightCalculatorState();
}

class _PretyWeightCalculatorState extends State<PretyWeightCalculator> {
  final TextEditingController dimensionController = TextEditingController();
  double? weight;

  void _calculateWeight() {
    final double dimension = double.tryParse(dimensionController.text) ?? 0.0;

    if (dimension > 0) {
      final weightValue = 3.14159 * (dimension * dimension) * 7.85 / 4000;
      setState(() {
        weight = weightValue;
      });
    } else {
      setState(() {
        weight = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prety Weight Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: dimensionController,
              decoration: InputDecoration(
                labelText: 'Średnica [mm]',
                labelStyle: Theme.of(context).textTheme.bodyLarge,
              ),
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calculateWeight,
              child: Text(
                'Oblicz wagę',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(height: 16.0),
            if (weight != null)
              Text(
                'Waga: ${weight!.toStringAsFixed(2)} kg',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
          ],
        ),
      ),
    );
  }
}
