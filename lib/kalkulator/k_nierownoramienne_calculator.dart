import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class KNieRownoramienneWeightCalculator extends StatefulWidget {
  const KNieRownoramienneWeightCalculator({Key? key}) : super(key: key);

  @override
  KNieRownoramienneWeightCalculatorState createState() => KNieRownoramienneWeightCalculatorState();
}

class KNieRownoramienneWeightCalculatorState extends State<KNieRownoramienneWeightCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Katowniki nierównoramienne'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate appropriate font sizes based on screen width
          double screenWidth = constraints.maxWidth;
          double fontSize = screenWidth * 0.035; // Adjust multiplier as needed
          double leftColumnWidth = screenWidth * 0.25;
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
    List<Map<String, dynamic>> selectedData = nierownoramiennneData;
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

List<Map<String, dynamic>> nierownoramiennneData = [
  {
    'Nazwa': '30x20x3',
    'a': 30,
    'b': 20,
    't': 3,
    'R': 4,
    'cm²': 1.43,
    'kg/m': 0,
  },
  {
    'Nazwa': '30x20x4',
    'a': 30,
    'b': 20,
    't': 4,
    'R': 4,
    'cm²': 1.86,
    'kg/m': 0,
  },
  {
    'Nazwa': '40x20x4',
    'a': 40,
    'b': 20,
    't': 4,
    'R': 4,
    'cm²': 2.26,
    'kg/m': 0,
  },
  {
    'Nazwa': '40x25x4',
    'a': 40,
    'b': 25,
    't': 4,
    'R': 4,
    'cm²': 2.46,
    'kg/m': 0,
  },
  {
    'Nazwa': '45x30x4',
    'a': 45,
    'b': 30,
    't': 4,
    'R': 4.5,
    'cm²': 2.87,
    'kg/m': 0,
  },
  {
    'Nazwa': '50x30x5',
    'a': 50,
    'b': 30,
    't': 5,
    'R': 5,
    'cm²': 3.78,
    'kg/m': 0,
  },
  {
    'Nazwa': '60x30x5',
    'a': 60,
    'b': 30,
    't': 5,
    'R': 5,
    'cm²': 4.28,
    'kg/m': 0,
  },
  {
    'Nazwa': '60x40x5',
    'a': 60,
    'b': 40,
    't': 5,
    'R': 6,
    'cm²': 4.79,
    'kg/m': 0,
  },
  {
    'Nazwa': '60x40x6',
    'a': 60,
    'b': 40,
    't': 6,
    'R': 6,
    'cm²': 5.68,
    'kg/m': 0,
  },
  {
    'Nazwa': '65x50x5',
    'a': 65,
    'b': 50,
    't': 5,
    'R': 6,
    'cm²': 5.54,
    'kg/m': 0,
  },
  {
    'Nazwa': '70x50x6',
    'a': 70,
    'b': 50,
    't': 6,
    'R': 7,
    'cm²': 6.89,
    'kg/m': 0,
  },
  {
    'Nazwa': '75x50x6',
    'a': 75,
    'b': 50,
    't': 6,
    'R': 7,
    'cm²': 7.19,
    'kg/m': 0,
  },
  {
    'Nazwa': '75x50x8',
    'a': 75,
    'b': 50,
    't': 8,
    'R': 7,
    'cm²': 9.41,
    'kg/m': 0,
  },
  {
    'Nazwa': '80x40x6',
    'a': 80,
    'b': 40,
    't': 6,
    'R': 7,
    'cm²': 6.89,
    'kg/m': 0,
  },
  {
    'Nazwa': '80x40x8',
    'a': 80,
    'b': 40,
    't': 8,
    'R': 7,
    'cm²': 9.01,
    'kg/m': 0,
  },
  {
    'Nazwa': '80x60x7',
    'a': 80,
    'b': 60,
    't': 7,
    'R': 8,
    'cm²': 9.38,
    'kg/m': 0,
  },
  {
    'Nazwa': '100x50x6',
    'a': 100,
    'b': 50,
    't': 6,
    'R': 8,
    'cm²': 8.71,
    'kg/m': 0,
  },
  {
    'Nazwa': '100x50x8',
    'a': 100,
    'b': 50,
    't': 8,
    'R': 8,
    'cm²': 11.4,
    'kg/m': 0,
  },
  {
    'Nazwa': '100x65x7',
    'a': 100,
    'b': 65,
    't': 7,
    'R': 10,
    'cm²': 11.2,
    'kg/m': 0,
  },
  {
    'Nazwa': '100x65x8',
    'a': 100,
    'b': 65,
    't': 8,
    'R': 10,
    'cm²': 12.7,
    'kg/m': 0,
  },
  {
    'Nazwa': '100x65x10',
    'a': 100,
    'b': 65,
    't': 10,
    'R': 10,
    'cm²': 15.6,
    'kg/m': 0,
  },
  {
    'Nazwa': '100x75x8',
    'a': 100,
    'b': 75,
    't': 8,
    'R': 10,
    'cm²': 13.5,
    'kg/m': 0,
  },
  {
    'Nazwa': '100x75x10',
    'a': 100,
    'b': 75,
    't': 10,
    'R': 10,
    'cm²': 16.6,
    'kg/m': 0,
  },
  {
    'Nazwa': '100x75x12',
    'a': 100,
    'b': 75,
    't': 12,
    'R': 10,
    'cm²': 19.7,
    'kg/m': 0,
  },
  {
    'Nazwa': '120x80x8',
    'a': 120,
    'b': 80,
    't': 8,
    'R': 11,
    'cm²': 15.5,
    'kg/m': 0,
  },
  {
    'Nazwa': '120x80x10',
    'a': 120,
    'b': 80,
    't': 10,
    'R': 11,
    'cm²': 19.1,
    'kg/m': 0,
  },
  {
    'Nazwa': '120x80x12',
    'a': 120,
    'b': 80,
    't': 12,
    'R': 11,
    'cm²': 22.7,
    'kg/m': 0,
  },
  {
    'Nazwa': '125x75x8',
    'a': 125,
    'b': 75,
    't': 8,
    'R': 11,
    'cm²': 15.5,
    'kg/m': 0,
  },
  {
    'Nazwa': '125x75x10',
    'a': 125,
    'b': 75,
    't': 10,
    'R': 11,
    'cm²': 19.1,
    'kg/m': 0,
  },
  {
    'Nazwa': '125x75x12',
    'a': 125,
    'b': 75,
    't': 12,
    'R': 11,
    'cm²': 22.7,
    'kg/m': 0,
  },
  {
    'Nazwa': '135x65x8',
    'a': 135,
    'b': 65,
    't': 8,
    'R': 11,
    'cm²': 15.5,
    'kg/m': 0,
  },
  {
    'Nazwa': '135x65x10',
    'a': 135,
    'b': 65,
    't': 10,
    'R': 11,
    'cm²': 19.1,
    'kg/m': 0,
  },
  {
    'Nazwa': '150x75x9',
    'a': 150,
    'b': 75,
    't': 9,
    'R': 12,
    'cm²': 19.6,
    'kg/m': 0,
  },
  {
    'Nazwa': '150x75x10',
    'a': 150,
    'b': 75,
    't': 10,
    'R': 12,
    'cm²': 21.7,
    'kg/m': 0,
  },
  {
    'Nazwa': '150x75x12',
    'a': 150,
    'b': 75,
    't': 12,
    'R': 12,
    'cm²': 25.7,
    'kg/m': 0,
  },
  {
    'Nazwa': '150x75x15',
    'a': 150,
    'b': 75,
    't': 15,
    'R': 12,
    'cm²': 31.7,
    'kg/m': 0,
  },
  {
    'Nazwa': '150x90x10',
    'a': 150,
    'b': 90,
    't': 10,
    'R': 12,
    'cm²': 23.2,
    'kg/m': 0,
  },
  {
    'Nazwa': '150x90x12',
    'a': 150,
    'b': 90,
    't': 12,
    'R': 12,
    'cm²': 27.5,
    'kg/m': 0,
  },
  {
    'Nazwa': '150x90x15',
    'a': 150,
    'b': 90,
    't': 15,
    'R': 12,
    'cm²': 33.9,
    'kg/m': 0,
  },
  {
    'Nazwa': '150x100x10',
    'a': 150,
    'b': 100,
    't': 10,
    'R': 12,
    'cm²': 24.2,
    'kg/m': 0,
  },
  {
    'Nazwa': '150x100x12',
    'a': 150,
    'b': 100,
    't': 12,
    'R': 12,
    'cm²': 28.7,
    'kg/m': 0,
  },
  {
    'Nazwa': '200x100x10',
    'a': 200,
    'b': 100,
    't': 10,
    'R': 15,
    'cm²': 29.2,
    'kg/m': 0,
  },
  {
    'Nazwa': '200x100x12',
    'a': 200,
    'b': 100,
    't': 12,
    'R': 15,
    'cm²': 34.8,
    'kg/m': 0,
  },
  {
    'Nazwa': '200x100x15',
    'a': 200,
    'b': 100,
    't': 15,
    'R': 15,
    'cm²': 43,
    'kg/m': 0,
  },
  {
    'Nazwa': '200x150x12',
    'a': 200,
    'b': 150,
    't': 12,
    'R': 15,
    'cm²': 40.8,
    'kg/m': 0,
  },
  {
    'Nazwa': '200x150x15',
    'a': 200,
    'b': 150,
    't': 15,
    'R': 15,
    'cm²': 50.5,
    'kg/m': 0,
  },
  // Add more rows as needed
];
