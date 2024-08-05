import 'package:flutter/material.dart';

class RuryWeightCalculator extends StatefulWidget {
  const RuryWeightCalculator({super.key});

  @override
  _RuryWeightCalculatorState createState() => _RuryWeightCalculatorState();
}

class _RuryWeightCalculatorState extends State<RuryWeightCalculator> {
  final TextEditingController diameterController = TextEditingController();
  final TextEditingController thicknessController = TextEditingController();
  double? weight;

  void _calculateWeight() {
    final double diameter = double.tryParse(diameterController.text) ?? 0.0;
    final double thickness = double.tryParse(thicknessController.text) ?? 0.0;

    if (diameter > 0 && thickness > 0) {
      final double radius = diameter / 2;
      final double innerRadius = radius - thickness;
      final weightValue = 3.14159 * ((radius * radius) - (innerRadius * innerRadius)) * 7.85 / 1000;
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
        title: const Text('Rury Weight Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: diameterController,
              decoration: InputDecoration(
                labelText: 'Średnica zewnętrzna [mm]',
                labelStyle: Theme.of(context).textTheme.bodyLarge,
              ),
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextField(
              controller: thicknessController,
              decoration: InputDecoration(
                labelText: 'Grubość ścianki [mm]',
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
