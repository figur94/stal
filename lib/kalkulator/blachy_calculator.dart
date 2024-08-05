import 'package:flutter/material.dart';

class BlachyWeightCalculator extends StatefulWidget {
  BlachyWeightCalculator({Key? key}) : super(key: key);

  @override
  _BlachyWeightCalculatorState createState() => _BlachyWeightCalculatorState();
}

class _BlachyWeightCalculatorState extends State<BlachyWeightCalculator> {
  final TextEditingController widthController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController thicknessController = TextEditingController();
  double? weight;

  void _calculateWeight() {
    final double width = double.tryParse(widthController.text) ?? 0.0;
    final double length = double.tryParse(lengthController.text) ?? 0.0;
    final double thickness = double.tryParse(thicknessController.text) ?? 0.0;

    if (width > 0 && length > 0 && thickness > 0) {
      final calculatedWeight = 7.85 * width * length * thickness / 1000000;
      setState(() {
        weight = calculatedWeight;
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
        title: Text('Blachy Weight Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: widthController,
              decoration: InputDecoration(
                labelText: 'Szerokość [mm]',
                labelStyle: Theme.of(context).textTheme.bodyLarge,
              ),
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextField(
              controller: lengthController,
              decoration: InputDecoration(
                labelText: 'Długość [mm]',
                labelStyle: Theme.of(context).textTheme.bodyLarge,
              ),
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextField(
              controller: thicknessController,
              decoration: InputDecoration(
                labelText: 'Grubość [mm]',
                labelStyle: Theme.of(context).textTheme.bodyLarge,
              ),
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calculateWeight,
              child: Text('Oblicz wagę',
                style: Theme.of(context).textTheme.bodyLarge,),
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
