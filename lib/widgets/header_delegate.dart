
import 'package:flutter/material.dart';

class HeaderDelegate extends StatelessWidget {
  final List<String> titles;

  const HeaderDelegate({super.key, required this.titles});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        color: const Color.fromRGBO(249, 255, 251, 1.0),
        margin: const EdgeInsets.symmetric(horizontal: 0.0),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(titles.length, (index) {
              return Flexible(
                flex: 2,
                child: Text(
                  titles[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: index == 0 ? 16 : 14), // Example of different styling
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
