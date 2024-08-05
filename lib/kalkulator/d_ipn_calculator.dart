import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class D_IpnWeightCalculator extends StatefulWidget {
  const D_IpnWeightCalculator({super.key});

  @override
  D_IpnWeightCalculatorState createState() => D_IpnWeightCalculatorState();
}

class D_IpnWeightCalculatorState extends State<D_IpnWeightCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dwuteowniki IPN'),
        actions: [
          GestureDetector(
            child: IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                _showPhotoDialog(context);
              },
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double fontSize = screenWidth * 0.035;
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

  void _showPhotoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Wymiary ceownika'),
          content: Image.asset('assets/ceownik.jpg'), // Path to your photo asset
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTableKatowniki(double screenWidth, double fontSize, double leftColumnWidth, double rightColumnWidth) {
    List<Map<String, dynamic>> selectedData = ipnData;
    double columnWidth = rightColumnWidth / 7;

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
            _getRightHandSideColumnCell(selectedData[index]['h'].toString(), fontSize, columnWidth),
            _getRightHandSideColumnCell(selectedData[index]['b'].toString(), fontSize, columnWidth),
            _getRightHandSideColumnCell(selectedData[index]['s'].toString(), fontSize, columnWidth),
            _getRightHandSideColumnCell(selectedData[index]['t'].toString(), fontSize, columnWidth),
            _getRightHandSideColumnCell(selectedData[index]['r'].toString(), fontSize, columnWidth),
            _getRightHandSideColumnCell(selectedData[index]['r1'].toString(), fontSize, columnWidth),
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

  List<Widget> _getTitleWidget(double fontSize, double leftColumnWidth, double rightColumnWidth) {
    double columnWidth = rightColumnWidth / 7.0;
    return [
      _getTitleItemWidget('Nazwa', fontSize, leftColumnWidth),
      _getTitleItemWidget('h', fontSize, columnWidth),
      _getTitleItemWidget('b', fontSize, columnWidth),
      _getTitleItemWidget('s', fontSize, columnWidth),
      _getTitleItemWidget('t', fontSize, columnWidth),
      _getTitleItemWidget('r', fontSize, columnWidth),
      _getTitleItemWidget('r1', fontSize, columnWidth),
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


List<Map<String, dynamic>> ipnData = [
  {
    'Nazwa': 'IPN 80',
    'h': 80,
    'b': 42,
    's': 3.9,
    't': 5.9,
    'r': 3.9,
    'r1': 2.3,
    'kgm': 5.94,
  },
  {
    'Nazwa': 'IPN 100',
    'h': 100,
    'b': 50,
    's': 4.5,
    't': 6.8,
    'r': 4.5,
    'r1': 2.7,
    'kgm': 8.34,
  },
  {
    'Nazwa': 'IPN 120',
    'h': 120,
    'b': 58,
    's': 5.1,
    't': 7.7,
    'r': 5.1,
    'r1': 3.1,
    'kgm': 11.1,
  },
  {
    'Nazwa': 'IPN 140',
    'h': 140,
    'b': 66,
    's': 5.7,
    't': 8.6,
    'r': 5.7,
    'r1': 3.4,
    'kgm': 14.3,
  },
  {
    'Nazwa': 'IPN 160',
    'h': 160,
    'b': 74,
    's': 6.3,
    't': 9.5,
    'r': 6.3,
    'r1': 3.8,
    'kgm': 17.9,
  },
  {
    'Nazwa': 'IPN 180',
    'h': 180,
    'b': 82,
    's': 6.9,
    't': 10.4,
    'r': 6.9,
    'r1': 4.1,
    'kgm': 21.9,
  },
  {
    'Nazwa': 'IPN 200',
    'h': 200,
    'b': 90,
    's': 7.5,
    't': 11.3,
    'r': 7.5,
    'r1': 4.5,
    'kgm': 26.2,
  },
  {
    'Nazwa': 'IPN 220',
    'h': 220,
    'b': 98,
    's': 8.1,
    't': 12.2,
    'r': 8.1,
    'r1': 4.9,
    'kgm': 31.1,
  },
  {
    'Nazwa': 'IPN 240',
    'h': 240,
    'b': 106,
    's': 8.7,
    't': 13.1,
    'r': 8.7,
    'r1': 5.2,
    'kgm': 36.2,
  },
  {
    'Nazwa': 'IPN 260',
    'h': 260,
    'b': 113,
    's': 9.4,
    't': 14.1,
    'r': 9.4,
    'r1': 5.6,
    'kgm': 41.9,
  },
  {
    'Nazwa': 'IPN 300',
    'h': 300,
    'b': 125,
    's': 10.8,
    't': 16.2,
    'r': 10.8,
    'r1': 6.5,
    'kgm': 54.2,
  },
  {
    'Nazwa': 'IPN 340',
    'h': 340,
    'b': 137,
    's': 12.2,
    't': 18.3,
    'r': 12.2,
    'r1': 7.3,
    'kgm': 68.0,
  },
  {
    'Nazwa': 'IPN 360',
    'h': 360,
    'b': 143,
    's': 13.0,
    't': 19.5,
    'r': 13.0,
    'r1': 7.8,
    'kgm': 76.1,
  },
  {
    'Nazwa': 'IPN 400',
    'h': 400,
    'b': 155,
    's': 14.4,
    't': 21.6,
    'r': 14.4,
    'r1': 8.6,
    'kgm': 92.4,
  },
  {
    'Nazwa': 'IPN 450',
    'h': 450,
    'b': 170,
    's': 16.2,
    't': 24.3,
    'r': 16.2,
    'r1': 9.7,
    'kgm': 115.0,
  },
  {
    'Nazwa': 'IPN 500',
    'h': 500,
    'b': 185,
    's': 18.0,
    't': 27.0,
    'r': 18.0,
    'r1': 10.8,
    'kgm': 141.0,
  },
  {
    'Nazwa': 'IPN 550',
    'h': 550,
    'b': 200,
    's': 19.0,
    't': 30.0,
    'r': 19.0,
    'r1': 11.9,
    'kgm': 166.0,
  },
];
