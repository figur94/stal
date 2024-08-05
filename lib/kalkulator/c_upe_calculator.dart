import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class C_UpeWeightCalculator extends StatefulWidget {
  const C_UpeWeightCalculator({super.key});

  @override
  C_UpeWeightCalculatorState createState() => C_UpeWeightCalculatorState();
}

class C_UpeWeightCalculatorState extends State<C_UpeWeightCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ceowniki UPE',),
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
    List<Map<String, dynamic>> selectedData = upeData;
    double columnWidth = rightColumnWidth / 7;

    return HorizontalDataTable(
      leftHandSideColumnWidth: leftColumnWidth,
      rightHandSideColumnWidth: rightColumnWidth,
      isFixedHeader: true,
      headerWidgets: _getTitleWidget(fontSize, leftColumnWidth,rightColumnWidth),
      leftSideItemBuilder: (context, index) {
        return Container(
          child: Text(
            selectedData[index]['oznaczenie'],
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
            _getRightHandSideColumnCell(selectedData[index]['h'].toString(), fontSize, columnWidth),
            _getRightHandSideColumnCell(selectedData[index]['s'].toString(), fontSize, columnWidth),
            _getRightHandSideColumnCell(selectedData[index]['g'].toString(), fontSize, columnWidth),
            _getRightHandSideColumnCell(selectedData[index]['t'].toString(), fontSize, columnWidth),
            _getRightHandSideColumnCell(selectedData[index]['r'].toString(), fontSize, columnWidth),
            _getRightHandSideColumnCell(selectedData[index]['cm2'].toString(), fontSize, columnWidth),
            _getRightHandSideColumnCell(selectedData[index]['kgm'].toString(), fontSize, columnWidth, fontWeight: FontWeight.bold),
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

  List<Widget> _getTitleWidget(double fontSize, double leftColumnWidth,double rightColumnWidth) {
    double columnWidth = rightColumnWidth / 7;
    return [
      _getTitleItemWidget('Nazwa', fontSize, leftColumnWidth),
      _getTitleItemWidget('h', fontSize, columnWidth),
      _getTitleItemWidget('b', fontSize, columnWidth),
      _getTitleItemWidget('tw', fontSize, columnWidth),
      _getTitleItemWidget('tf', fontSize, columnWidth),
      _getTitleItemWidget('r', fontSize, columnWidth),
      _getTitleItemWidget('A', fontSize, columnWidth),
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


List<Map<String, dynamic>> upeData = [
  {
    'oznaczenie': 'UPE 80',
    'h': 80,
    's': 50,
    'g': 4.0,
    't': 7,
    'r': 10,
    'cm2': 10.1,
    'kgm': 7.9,
  },
  {
    'oznaczenie': 'UPE 100',
    'h': 100,
    's': 55,
    'g': 4.5,
    't': 7.5,
    'r': 10,
    'cm2': 12.5,
    'kgm': 9.82,
  },
  {
    'oznaczenie': 'UPE 120',
    'h': 120,
    's': 60,
    'g': 5.0,
    't': 8,
    'r': 12,
    'cm2': 15.4,
    'kgm': 12.1,
  },
  {
    'oznaczenie': 'UPE 140',
    'h': 140,
    's': 65,
    'g': 5.0,
    't': 9,
    'r': 12,
    'cm2': 18.4,
    'kgm': 14.5,
  },
  {
    'oznaczenie': 'UPE 160',
    'h': 160,
    's': 70,
    'g': 5.5,
    't': 9.5,
    'r': 12,
    'cm2': 21.7,
    'kgm': 17,
  },
  {
    'oznaczenie': 'UPE 180',
    'h': 180,
    's': 75,
    'g': 5.5,
    't': 10.5,
    'r': 12,
    'cm2': 25.1,
    'kgm': 19.7,
  },
  {
    'oznaczenie': 'UPE 200',
    'h': 200,
    's': 80,
    'g': 6.0,
    't': 11,
    'r': 13,
    'cm2': 29,
    'kgm': 22.8,
  },
  {
    'oznaczenie': 'UPE 220',
    'h': 220,
    's': 85,
    'g': 6.5,
    't': 12,
    'r': 13,
    'cm2': 33.9,
    'kgm': 26.6,
  },
  {
    'oznaczenie': 'UPE 240',
    'h': 240,
    's': 90,
    'g': 7.0,
    't': 12.5,
    'r': 15,
    'cm2': 38.5,
    'kgm': 30.2,
  },
  {
    'oznaczenie': 'UPE 270',
    'h': 270,
    's': 95,
    'g': 7.5,
    't': 13.5,
    'r': 15,
    'cm2': 44.8,
    'kgm': 35.2,
  },
  {
    'oznaczenie': 'UPE 300',
    'h': 300,
    's': 100,
    'g': 9.5,
    't': 15,
    'r': 15,
    'cm2': 56.6,
    'kgm': 44.4,
  },
  {
    'oznaczenie': 'UPE 330',
    'h': 330,
    's': 105,
    'g': 11.0,
    't': 16,
    'r': 18,
    'cm2': 67.8,
    'kgm': 53.2,
  },
  {
    'oznaczenie': 'UPE 360',
    'h': 360,
    's': 110,
    'g': 12,
    't': 17,
    'r': 18,
    'cm2': 77.9,
    'kgm': 61.2,
  },
  {
    'oznaczenie': 'UPE 400',
    'h': 400,
    's': 115,
    'g': 13.5,
    't': 18,
    'r': 18,
    'cm2': 91.9,
    'kgm': 72.2,
  },
];
