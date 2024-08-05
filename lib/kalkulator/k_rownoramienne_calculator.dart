import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class KRownoramienneWeightCalculator extends StatefulWidget {
  const KRownoramienneWeightCalculator({super.key});

  @override
  KRownoramienneWeightCalculatorState createState() => KRownoramienneWeightCalculatorState();
}

class KRownoramienneWeightCalculatorState extends State<KRownoramienneWeightCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Katowniki równoramienne'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate appropriate font sizes based on screen width
          double screenWidth = constraints.maxWidth;
          double fontSize = screenWidth * 0.035; // Adjust multiplier as needed
          double leftColumnWidth = screenWidth * 0.25; // Increased width for the "Nazwa" column
          double rightColumnWidth = screenWidth - leftColumnWidth - 16;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: _buildTableKatowniki(screenWidth, fontSize, leftColumnWidth, rightColumnWidth),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTableKatowniki(double screenWidth, double fontSize, double leftColumnWidth, double rightColumnWidth) {
    List<Map<String, dynamic>> selectedData = rownoramienneData;
    double columnWidth = rightColumnWidth / 5;

    return HorizontalDataTable(
      leftHandSideColumnWidth: leftColumnWidth,
      rightHandSideColumnWidth: rightColumnWidth,
      isFixedHeader: true,
      headerWidgets: _getTitleWidget(fontSize, leftColumnWidth, rightColumnWidth),
      leftSideItemBuilder: (context, index) {
        return Container(
          child: Text(
            selectedData[index]['Nazwa'],
            style: TextStyle(fontSize: fontSize, color: Colors.grey, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          width: leftColumnWidth,
          height: 52,
          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.centerLeft,
        );
      },
      rightSideItemBuilder: (context, index) {
        return Row(
          children: <Widget>[
            _getRightHandSideColumnCell(selectedData[index]['a'].toString(), fontSize, columnWidth),
            _getRightHandSideColumnCell(selectedData[index]['t'].toString(), fontSize, columnWidth),
            _getRightHandSideColumnCell(selectedData[index]['R'].toString(), fontSize, columnWidth),
            _getRightHandSideColumnCell(selectedData[index]['cm²'].toString(), fontSize, columnWidth),
            _getRightHandSideColumnCell(selectedData[index]['kg/m'].toString(), fontSize, columnWidth, fontWeight: FontWeight.bold),
          ],
        );
      },
      itemCount: selectedData.length,
      rowSeparatorWidget: const Divider(
        color: Colors.black54,
        height: 1.0,
        thickness: 0.0,
      ),
      leftHandSideColBackgroundColor: Colors.white,
      rightHandSideColBackgroundColor: Colors.white,
    );
  }

  List<Widget> _getTitleWidget(double fontSize, double leftColumnWidth, double rightColumnWidth) {
    double columnWidth = rightColumnWidth / 5;
    return [
      _getTitleItemWidget('Nazwa', fontSize, leftColumnWidth),
      _getTitleItemWidget('a', fontSize, columnWidth),
      _getTitleItemWidget('t', fontSize, columnWidth),
      _getTitleItemWidget('R', fontSize, columnWidth),
      _getTitleItemWidget('cm²', fontSize, columnWidth),
      _getTitleItemWidget('kg/m', fontSize, columnWidth),
    ];
  }

  Widget _getTitleItemWidget(String label, double fontSize, double width) {
    return Container(
      child: Text(
        label,
        style: TextStyle(fontSize: fontSize, color: Colors.grey),
        overflow: TextOverflow.ellipsis,
      ),
      width: width,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _getRightHandSideColumnCell(String label, double fontSize, double width, {FontWeight fontWeight = FontWeight.normal}) {
    return Container(
      child: Text(
        label,
        style: TextStyle(fontSize: fontSize, color: Colors.grey, fontWeight: fontWeight),
        overflow: TextOverflow.ellipsis,
      ),
      width: width,
      height: 52,
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.centerLeft,
    );
  }
}



List<Map<String, dynamic>> rownoramienneData = [
  {
    'Nazwa': '20x20x3',
    'a': 20,
    't': 3,
    'R': 3.5,
    'cm²': 1.12,
    'kg/m': 0.88,
  },
  {
    'Nazwa': '25x25x3',
    'a': 25,
    't': 3,
    'R': 3.5,
    'cm²': 1.42,
    'kg/m': 1.12,
  },
  {
    'Nazwa': '25x25x4',
    'a': 25,
    't': 4,
    'R': 3.5,
    'cm²': 1.85,
    'kg/m': 1.45,
  },
  {
    'Nazwa': '30x30x3',
    'a': 30,
    't': 3,
    'R': 5,
    'cm²': 1.74,
    'kg/m': 1.36,
  },
  {
    'Nazwa': '30x30x4',
    'a': 30,
    't': 4,
    'R': 5,
    'cm²': 2.27,
    'kg/m': 1.78,
  },
  {
    'Nazwa': '30x30x5',
    'a': 30,
    't': 5,
    'R': 5,
    'cm²': 2.78,
    'kg/m': 2.18,
  },
  {
    'Nazwa': '35x35x3',
    'a': 35,
    't': 3,
    'R': 5,
    'cm²': 2.04,
    'kg/m': 1.6,
  },
  {
    'Nazwa': '35x35x4',
    'a': 35,
    't': 4,
    'R': 5,
    'cm²': 2.67,
    'kg/m': 2.1,
  },
  {
    'Nazwa': '40x40x3',
    'a': 40,
    't': 3,
    'R': 6,
    'cm²': 2.35,
    'kg/m': 1.84,
  },
  {
    'Nazwa': '40x40x4',
    'a': 40,
    't': 4,
    'R': 6,
    'cm²': 3.08,
    'kg/m': 2.42,
  },
  {
    'Nazwa': '40x40x5',
    'a': 40,
    't': 5,
    'R': 6,
    'cm²': 3.79,
    'kg/m': 2.97,
  },
  {
    'Nazwa': '40x40x6',
    'a': 40,
    't': 6,
    'R': 6,
    'cm²': 4.48,
    'kg/m': 3.52,
  },
  {
    'Nazwa': '45x45x3',
    'a': 45,
    't': 3,
    'R': 7,
    'cm²': 2.66,
    'kg/m': 2.09,
  },
  {
    'Nazwa': '45x45x4,5',
    'a': 45,
    't': 4.5,
    'R': 7,
    'cm²': 3.9,
    'kg/m': 3.06,
  },
  {
    'Nazwa': '45x45x6',
    'a': 45,
    't': 6,
    'R': 7,
    'cm²': 5.09,
    'kg/m': 4,
  },
  {
    'Nazwa': '50x50x3',
    'a': 50,
    't': 3,
    'R': 7,
    'cm²': 2.96,
    'kg/m': 2.32,
  },
  {
    'Nazwa': '50x50x4',
    'a': 50,
    't': 4,
    'R': 7,
    'cm²': 3.89,
    'kg/m': 3.06,
  },
  {
    'Nazwa': '50x50x5',
    'a': 50,
    't': 5,
    'R': 7,
    'cm²': 4.8,
    'kg/m': 3.77,
  },
  {
    'Nazwa': '50x50x6',
    'a': 50,
    't': 6,
    'R': 7,
    'cm²': 5.69,
    'kg/m': 4.47,
  },
  {
    'Nazwa': '60x60x5',
    'a': 60,
    't': 5,
    'R': 8,
    'cm²': 5.82,
    'kg/m': 4.57,
  },
  {
    'Nazwa': '60x60x6',
    'a': 60,
    't': 6,
    'R': 8,
    'cm²': 6.91,
    'kg/m': 5.42,
  },
  {
    'Nazwa': '60x60x8',
    'a': 60,
    't': 8,
    'R': 8,
    'cm²': 9.03,
    'kg/m': 7.09,
  },
  {
    'Nazwa': '65x65x7',
    'a': 65,
    't': 7,
    'R': 9,
    'cm²': 8.7,
    'kg/m': 6.83,
  },
  {
    'Nazwa': '70x70x6',
    'a': 70,
    't': 6,
    'R': 9,
    'cm²': 8.13,
    'kg/m': 6.38,
  },
  {
    'Nazwa': '70x70x7',
    'a': 70,
    't': 7,
    'R': 9,
    'cm²': 9.4,
    'kg/m': 7.38,
  },
  {
    'Nazwa': '75x75x6',
    'a': 75,
    't': 6,
    'R': 9,
    'cm²': 8.73,
    'kg/m': 6.85,
  },
  {
    'Nazwa': '75x75x8',
    'a': 75,
    't': 8,
    'R': 9,
    'cm²': 11.5,
    'kg/m': 9.03,
  },
  {
    'Nazwa': '75x75x10',
    'a': 75,
    't': 10,
    'R': 9,
    'cm²': 14.1,
    'kg/m': 11.1,
  },
  {
    'Nazwa': '75x75x12',
    'a': 75,
    't': 12,
    'R': 9,
    'cm²': 16.6,
    'kg/m': 13.1,
  },
  {
    'Nazwa': '80x80x8',
    'a': 80,
    't': 8,
    'R': 10,
    'cm²': 12.3,
    'kg/m': 9.66,
  },
  {
    'Nazwa': '80x80x10',
    'a': 80,
    't': 10,
    'R': 10,
    'cm²': 15.1,
    'kg/m': 11.9,
  },
  {
    'Nazwa': '90x90x7',
    'a': 90,
    't': 7,
    'R': 11,
    'cm²': 12.2,
    'kg/m': 9.58,
  },
  {
    'Nazwa': '90x90x8',
    'a': 90,
    't': 8,
    'R': 11,
    'cm²': 13.9,
    'kg/m': 10.9,
  },
  {
    'Nazwa': '90x90x9',
    'a': 90,
    't': 9,
    'R': 11,
    'cm²': 15.5,
    'kg/m': 12.2,
  },
  {
    'Nazwa': '90x90x10',
    'a': 90,
    't': 10,
    'R': 11,
    'cm²': 17.1,
    'kg/m': 13.5,
  },
  {
    'Nazwa': '100x100x6',
    'a': 100,
    't': 6,
    'R': 12,
    'cm²': 11.8,
    'kg/m': 9.26,
  },
  {
    'Nazwa': '100x100x7',
    'a': 100,
    't': 7,
    'R': 12,
    'cm²': 13.7,
    'kg/m': 10.7,
  },
  {
    'Nazwa': '100x100x8',
    'a': 100,
    't': 8,
    'R': 12,
    'cm²': 15.5,
    'kg/m': 12.2,
  },
  {
    'Nazwa': '100x100x10',
    'a': 100,
    't': 10,
    'R': 12,
    'cm²': 19.2,
    'kg/m': 15.1,
  },
  {
    'Nazwa': '100x100x12',
    'a': 100,
    't': 12,
    'R': 12,
    'cm²': 22.7,
    'kg/m': 17.8,
  },
  {
    'Nazwa': '120x120x10',
    'a': 120,
    't': 10,
    'R': 13,
    'cm²': 23.2,
    'kg/m': 18.2,
  },
  {
    'Nazwa': '120x120x12',
    'a': 120,
    't': 12,
    'R': 13,
    'cm²': 27.5,
    'kg/m': 21.6,
  },
  {
    'Nazwa': '130x130x12',
    'a': 130,
    't': 12,
    'R': 13,
    'cm²': 29.9,
    'kg/m': 23.5,
  },
  {
    'Nazwa': '150x150x10',
    'a': 150,
    't': 10,
    'R': 16,
    'cm²': 29.3,
    'kg/m': 23,
  },
  {
    'Nazwa': '150x150x12',
    'a': 150,
    't': 12,
    'R': 15,
    'cm²': 34.8,
    'kg/m': 27.3,
  },
  {
    'Nazwa': '150x150x15',
    'a': 150,
    't': 15,
    'R': 15,
    'cm²': 43,
    'kg/m': 33.8,
  },
  {
    'Nazwa': '160x160x15',
    'a': 160,
    't': 15,
    'R': 17,
    'cm²': 36.2,
    'kg/m': 46.1,
  },
  {
    'Nazwa': '180x180x16',
    'a': 180,
    't': 16,
    'R': 18,
    'cm²': 55.4,
    'kg/m': 43.5,
  },
  {
    'Nazwa': '180x180x18',
    'a': 180,
    't': 18,
    'R': 18,
    'cm²': 61.9,
    'kg/m': 48.6,
  },
  {
    'Nazwa': '200x200x16',
    'a': 200,
    't': 16,
    'R': 18,
    'cm²': 61.8,
    'kg/m': 48.5,
  },
  {
    'Nazwa': '200x200x18',
    'a': 200,
    't': 18,
    'R': 18,
    'cm²': 69.1,
    'kg/m': 54.3,
  },
  {
    'Nazwa': '200x200x20',
    'a': 200,
    't': 20,
    'R': 18,
    'cm²': 76.4,
    'kg/m': 59.9,
  },
  {
    'Nazwa': '200x200x24',
    'a': 200,
    't': 24,
    'R': 18,
    'cm²': 90.6,
    'kg/m': 71.1,
  },
  {
    'Nazwa': '250x250x28',
    'a': 250,
    't': 28,
    'R': 18,
    'cm²': 133,
    'kg/m': 104,
  },
  {
    'Nazwa': '250x250x35',
    'a': 250,
    't': 36,
    'R': 18,
    'cm²': 163,
    'kg/m': 128,
  },
  // Add more rows as needed
];
