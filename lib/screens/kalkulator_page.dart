import 'package:flutter/material.dart';
import 'package:stal/kalkulator/d_ipn_calculator.dart';
import 'package:stal/kalkulator/d_ipe_calculator.dart';
import 'package:stal/kalkulator/c_upn_calculator.dart';
import 'package:stal/kalkulator/c_upe_calculator.dart';
import 'package:stal/kalkulator/d_heabcm_calculator.dart';
import 'package:stal/kalkulator/rury_calculator.dart';
import 'package:stal/kalkulator/blachy_calculator.dart';
import 'package:stal/kalkulator/k_rownoramienne_calculator.dart';
import 'package:stal/kalkulator/k_nierownoramienne_calculator.dart';
import 'package:stal/kalkulator/profile_calculator.dart';
import 'package:stal/kalkulator/prety_calculator.dart';

class KalkulatorPage extends StatefulWidget {
  const KalkulatorPage({super.key});

  @override
  _KalkulatorPageState createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {



  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double buttonWidth = screenSize.width * 0.4; // Adjust this ratio as needed
    const double buttonHeight = 90; // Set a fixed height for the buttons

    return Scaffold(
        appBar: AppBar(
          title: Text('Wymiary i wagi'),
        ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First row of buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const D_IpnWeightCalculator()),
                          );
                        },
                        child: const Text('IPN'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Adjust the spacing between buttons
                  Expanded(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const D_IpeWeightCalculator()),
                          );
                        },
                        child: const Text('IPE'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Adjust the spacing between buttons
                  Expanded(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const D_HeabWeightCalculator()),
                          );
                        },
                        child: const Text('HE A,B,C,M'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Adjust the vertical spacing between rows
              // Second row of buttons
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const C_UpnWeightCalculator()),
                          );
                        },
                        child: const Text('UPN'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Adjust the spacing between buttons
                  Expanded(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const C_UpeWeightCalculator()),
                          );
                        },
                        child: const Text('UPE'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const KRownoramienneWeightCalculator()),
                          );
                        },
                        child: const Text('RÓWNORAMIENNE'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Adjust the spacing between buttons
                  Expanded(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const KNieRownoramienneWeightCalculator()),
                          );
                        },
                        child: const Text('NIERÓWNORAMIENNE'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Adjust the vertical spacing between rows
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  BlachyWeightCalculator()),
                          );
                        },
                        child: const Text('BLACHY I PŁASKOWNIKI'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Adjust the vertical spacing between rows
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ProfileWeightCalculator()),
                          );
                        },
                        child: const Text('PROFILE STALOWE'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20), // Adjust the vertical spacing between rows
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const RuryWeightCalculator()),
                          );
                        },
                        child: const Text('RURY STALOWE'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PretyWeightCalculator()),
                          );
                        },
                        child: const Text('PRĘTY STALOWE'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
