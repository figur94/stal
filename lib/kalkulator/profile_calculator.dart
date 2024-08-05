import 'package:flutter/material.dart';

class ProfileWeightCalculator extends StatefulWidget {
  const ProfileWeightCalculator({super.key});

  @override
  _ProfileWeightCalculatorState createState() => _ProfileWeightCalculatorState();
}

class _ProfileWeightCalculatorState extends State<ProfileWeightCalculator> {
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController thicknessController = TextEditingController();
  double? weight;

  void _calculateWeight() {
    final double width = double.tryParse(widthController.text) ?? 0.0;
    final double height = double.tryParse(heightController.text) ?? 0.0;
    final double thickness = double.tryParse(thicknessController.text) ?? 0.0;

    if (width > 0 && height > 0 && thickness > 0) {
      final weightValue = 7.85 * (2 * (height + width - 2 * thickness) * thickness) / 1000;
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
        title: const Text('Profile Weight Calculator'),
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
              controller: heightController,
              decoration: InputDecoration(
                labelText: 'Wysokość [mm]',
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
