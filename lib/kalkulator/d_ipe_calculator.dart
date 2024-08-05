import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class D_IpeWeightCalculator extends StatefulWidget {
  const D_IpeWeightCalculator({super.key});

  @override
  D_IpeWeightCalculatorState createState() => D_IpeWeightCalculatorState();
}

class D_IpeWeightCalculatorState extends State<D_IpeWeightCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dwuteowniki IPE',),
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
    List<Map<String, dynamic>> selectedData = ipeData;
    double columnWidth = rightColumnWidth / 6;

    return HorizontalDataTable(
      leftHandSideColumnWidth: leftColumnWidth,
      rightHandSideColumnWidth: rightColumnWidth,
      isFixedHeader: true,
      headerWidgets: _getTitleWidget(fontSize, leftColumnWidth,rightColumnWidth),
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
              _getRightHandSideColumnCell(selectedData[index]['kgm'].toString(), fontSize,columnWidth, fontWeight: FontWeight.bold),
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
    double columnWidth = rightColumnWidth / 6;
    return [
      _getTitleItemWidget('Nazwa', fontSize, leftColumnWidth),
      _getTitleItemWidget('h', fontSize, columnWidth),
      _getTitleItemWidget('b', fontSize, columnWidth),
      _getTitleItemWidget('s', fontSize, columnWidth),
      _getTitleItemWidget('t', fontSize, columnWidth),
      _getTitleItemWidget('r', fontSize, columnWidth),
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


List<Map<String, dynamic>> ipeData = [
  {
    'Nazwa': 'IPE 80',
    'h': 80,
    'b': 46,
    's': 3.8,
    't': 5.2,
    'r': 5.0,
    'kgm': 6.19,
  },
  {
    'Nazwa': 'IPE 100',
    'h': 100,
    'b': 55,
    's': 4.1,
    't': 5.7,
    'r': 7.0,
    'kgm': 8.34,
  },
  {
    'Nazwa': 'IPE 120',
    'h': 120,
    'b': 64,
    's': 4.4,
    't': 6.3,
    'r': 7.0,
    'kgm': 10.7,
  },
  {
    'Nazwa': 'IPE 140',
    'h': 140,
    'b': 73,
    's': 4.7,
    't': 6.9,
    'r': 7.0,
    'kgm': 13.3,
  },
  {
    'Nazwa': 'IPE 160',
    'h': 160,
    'b': 82,
    's': 5.0,
    't': 7.4,
    'r': 9.0,
    'kgm': 16.2,
  },
  {
    'Nazwa': 'IPE 180',
    'h': 180,
    'b': 91,
    's': 5.3,
    't': 8.0,
    'r': 9.0,
    'kgm': 19.5,
  },
  {
    'Nazwa': 'IPE 200',
    'h': 200,
    'b': 100,
    's': 5.6,
    't': 8.5,
    'r': 12.0,
    'kgm': 23.1,
  },
  {
    'Nazwa': 'IPE 220',
    'h': 220,
    'b': 110,
    's': 5.9,
    't': 9.2,
    'r': 12.0,
    'kgm': 27.2,
  },
  {
    'Nazwa': 'IPE 240',
    'h': 240,
    'b': 120,
    's': 6.2,
    't': 9.8,
    'r': 15.0,
    'kgm': 31.5,
  },
  {
    'Nazwa': 'IPE 270',
    'h': 270,
    'b': 135,
    's': 6.6,
    't': 10.2,
    'r': 15.0,
    'kgm': 36.1,
  },
  {
    'Nazwa': 'IPE 300',
    'h': 300,
    'b': 150,
    's': 7.1,
    't': 10.7,
    'r': 15.0,
    'kgm': 42.2,
  },
  {
    'Nazwa': 'IPE 330',
    'h': 330,
    'b': 160,
    's': 7.5,
    't': 11.5,
    'r': 18.0,
    'kgm': 49.1,
  },
  {
    'Nazwa': 'IPE 360',
    'h': 360,
    'b': 170,
    's': 8.0,
    't': 12.7,
    'r': 18.0,
    'kgm': 57.1,
  },
  {
    'Nazwa': 'IPE 400',
    'h': 400,
    'b': 180,
    's': 8.6,
    't': 13.5,
    'r': 21.0,
    'kgm': 66.3,
  },
  {
    'Nazwa': 'IPE 450',
    'h': 450,
    'b': 190,
    's': 9.4,
    't': 14.6,
    'r': 21.0,
    'kgm': 77.6,
  },
  {
    'Nazwa': 'IPE 500',
    'h': 500,
    'b': 200,
    's': 10.2,
    't': 16.0,
    'r': 21.0,
    'kgm': 90.7,
  },
  {
    'Nazwa': 'IPE 550',
    'h': 550,
    'b': 210,
    's': 11.1,
    't': 17.2,
    'r': 24.0,
    'kgm': 106.0,
  },
  {
    'Nazwa': 'IPE 600',
    'h': 600,
    'b': 220,
    's': 12.0,
    't': 19.0,
    'r': 24.0,
    'kgm': 122.0,
  },
];
