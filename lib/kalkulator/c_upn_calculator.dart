import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class C_UpnWeightCalculator extends StatefulWidget {
  const C_UpnWeightCalculator({super.key});

  @override
  C_UpnWeightCalculatorState createState() => C_UpnWeightCalculatorState();
}

class C_UpnWeightCalculatorState extends State<C_UpnWeightCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ceowniki UPN',),
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
    List<Map<String, dynamic>> selectedData = upnData;
    double columnWidth = rightColumnWidth / 8;

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
            _getRightHandSideColumnCell(selectedData[index]['r1'].toString(), fontSize, columnWidth),
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
    double columnWidth = rightColumnWidth / 8;
    return [
      _getTitleItemWidget('Nazwa', fontSize, leftColumnWidth),
      _getTitleItemWidget('h', fontSize, columnWidth),
      _getTitleItemWidget('s', fontSize, columnWidth),
      _getTitleItemWidget('g', fontSize, columnWidth),
      _getTitleItemWidget('t', fontSize, columnWidth),
      _getTitleItemWidget('r', fontSize, columnWidth),
      _getTitleItemWidget('r1', fontSize, columnWidth),
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


List<Map<String, dynamic>> upnData = [
  {
    'oznaczenie': 'UPN 35',
    'h': 35,
    's': 35,
    'g': 5.0,
    't': 6,
    'r': 6,
    'r1': 3,
    'cm2': 5.27,
    'kgm': 4.14,
  },
  {
    'oznaczenie': 'UPN 40',
    'h': 40,
    's': 20,
    'g': 5.0,
    't': 5,
    'r': 5,
    'r1': 2.5,
    'cm2': 3.51,
    'kgm': 2.75,
  },
  {
    'oznaczenie': 'UPN 45',
    'h': 45,
    's': 38,
    'g': 5.0,
    't': 6,
    'r': 6,
    'r1': 3,
    'cm2': 6.41,
    'kgm': 5.03,
  },
  {
    'oznaczenie': 'UPN 50',
    'h': 50,
    's': 38,
    'g': 5.5,
    't': 7,
    'r': 7,
    'r1': 3.5,
    'cm2': 7.12,
    'kgm': 5.59,
  },
  {
    'oznaczenie': 'UPN 65',
    'h': 65,
    's': 42,
    'g': 6.0,
    't': 7.5,
    'r': 7.5,
    'r1': 4,
    'cm2': 9.03,
    'kgm': 7.09,
  },
  {
    'oznaczenie': 'UPN 80',
    'h': 80,
    's': 45,
    'g': 6.0,
    't': 8,
    'r': 8,
    'r1': 4,
    'cm2': 11,
    'kgm': 8.64,
  },
  {
    'oznaczenie': 'UPN 100',
    'h': 100,
    's': 50,
    'g': 6.0,
    't': 8.5,
    'r': 8.5,
    'r1': 4.5,
    'cm2': 13.5,
    'kgm': 10.6,
  },
  {
    'oznaczenie': 'UPN 120',
    'h': 120,
    's': 55,
    'g': 7.0,
    't': 9,
    'r': 9,
    'r1': 4.5,
    'cm2': 17,
    'kgm': 13.4,
  },
  {
    'oznaczenie': 'UPN 140',
    'h': 140,
    's': 60,
    'g': 7.0,
    't': 10,
    'r': 10,
    'r1': 5,
    'cm2': 20.4,
    'kgm': 16,
  },
  {
    'oznaczenie': 'UPN 160',
    'h': 160,
    's': 65,
    'g': 7.5,
    't': 10.5,
    'r': 10.5,
    'r1': 5.5,
    'cm2': 24,
    'kgm': 18.8,
  },
  {
    'oznaczenie': 'UPN 180',
    'h': 180,
    's': 70,
    'g': 8.0,
    't': 11,
    'r': 11,
    'r1': 5.5,
    'cm2': 28,
    'kgm': 22,
  },
  {
    'oznaczenie': 'UPN 200',
    'h': 200,
    's': 75,
    'g': 8.8,
    't': 11.5,
    'r': 11.5,
    'r1': 6,
    'cm2': 32.2,
    'kgm': 25.3,
  },
  {
    'oznaczenie': 'UPN 220',
    'h': 220,
    's': 80,
    'g': 9.0,
    't': 12.5,
    'r': 12.5,
    'r1': 6.5,
    'cm2': 37.4,
    'kgm': 29.4,
  },
  {
    'oznaczenie': 'UPN 240',
    'h': 240,
    's': 85,
    'g': 9.5,
    't': 13,
    'r': 13,
    'r1': 6.5,
    'cm2': 42.3,
    'kgm': 33.2,
  },
  {
    'oznaczenie': 'UPN 260',
    'h': 260,
    's': 90,
    'g': 10,
    't': 14,
    'r': 14,
    'r1': 7,
    'cm2': 48.3,
    'kgm': 37.9,
  },
  {
    'oznaczenie': 'UPN 280',
    'h': 280,
    's': 95,
    'g': 10,
    't': 15,
    'r': 15,
    'r1': 7.5,
    'cm2': 53.3,
    'kgm': 41.8,
  },
  {
    'oznaczenie': 'UPN 300',
    'h': 300,
    's': 100,
    'g': 10,
    't': 16,
    'r': 16,
    'r1': 8,
    'cm2': 58.8,
    'kgm': 46.2,
  },
];
