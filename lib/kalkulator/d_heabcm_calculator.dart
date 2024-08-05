import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class D_HeabWeightCalculator extends StatefulWidget {
  const D_HeabWeightCalculator({super.key});

  @override
  D_HeabWeightCalculatorState createState() => D_HeabWeightCalculatorState();
}

class D_HeabWeightCalculatorState extends State<D_HeabWeightCalculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dwuteowniki HE A,B,M,C',),
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
    List<Map<String, dynamic>> selectedData = heData;
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
            style: TextStyle(fontSize: fontSize, color: Colors.grey, fontWeight: FontWeight.bold,),
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


List<Map<String, dynamic>> heData = [
  {
    'Nazwa': 'HE 100 A',
    'h': 96,
    'b': 100,
    's': 5,
    't': 8,
    'r': 12,
    'kgm': 16.7,
  },
  {
    'Nazwa': 'HE 100 B',
    'h': 100,
    'b': 100,
    's': 6,
    't': 10,
    'r': 12,
    'kgm': 20.4,
  },
  {
    'Nazwa': 'HE 100 C',
    'h': 110,
    'b': 103,
    's': 9,
    't': 15,
    'r': 12,
    'kgm': 30.9,
  },
  {
    'Nazwa': 'HE 100 M',
    'h': 120,
    'b': 106,
    's': 12,
    't': 20,
    'r': 12,
    'kgm': 41.8,
  },
  {
    'Nazwa': 'HE 120 A',
    'h': 114,
    'b': 120,
    's': 5,
    't': 8,
    'r': 12,
    'kgm': 19.9,
  },
  {
    'Nazwa': 'HE 120 B',
    'h': 120,
    'b': 120,
    's': 6.5,
    't': 11,
    'r': 12,
    'kgm': 26.7,
  },
  {
    'Nazwa': 'HE 120 C',
    'h': 130,
    'b': 123,
    's': 9.5,
    't': 18,
    'r': 12,
    'kgm': 39.2,
  },
  {
    'Nazwa': 'HE 120 M',
    'h': 140,
    'b': 126,
    's': 12.5,
    't': 21,
    'r': 12,
    'kgm': 52.1,
  },
  {
    'Nazwa': 'HE 140 A',
    'h': 133,
    'b': 140,
    's': 5.5,
    't': 8.5,
    'r': 12,
    'kgm': 24.7,
  },
  {
    'Nazwa': 'HE 140 B',
    'h': 140,
    'b': 140,
    's': 7,
    't': 12,
    'r': 12,
    'kgm': 33.7,
  },
  {
    'Nazwa': 'HE 140 C',
    'h': 150,
    'b': 143,
    's': 10,
    't': 17,
    'r': 12,
    'kgm': 48.2,
  },
  {
    'Nazwa': 'HE 140 M',
    'h': 160,
    'b': 146,
    's': 13,
    't': 22,
    'r': 12,
    'kgm': 63.2,
  },
  {
    'Nazwa': 'HE 160 A',
    'h': 152,
    'b': 160,
    's': 6,
    't': 9,
    'r': 15,
    'kgm': 30.4,
  },
  {
    'Nazwa': 'HE 160 B',
    'h': 160,
    'b': 160,
    's': 8,
    't': 13,
    'r': 15,
    'kgm': 42.6,
  },
  {
    'Nazwa': 'HE 160 C',
    'h': 170,
    'b': 163,
    's': 11,
    't': 18,
    'r': 15,
    'kgm': 59.2,
  },
  {
    'Nazwa': 'HE 160 M',
    'h': 180,
    'b': 166,
    's': 14,
    't': 23,
    'r': 15,
    'kgm': 76.2,
  },
  {
    'Nazwa': 'HE 180 A',
    'h': 171,
    'b': 180,
    's': 6,
    't': 9.5,
    'r': 15,
    'kgm': 35.5,
  },
  {
    'Nazwa': 'HE 180 B',
    'h': 180,
    'b': 180,
    's': 8.5,
    't': 14,
    'r': 15,
    'kgm': 51.2,
  },
  {
    'Nazwa': 'HE 180 C',
    'h': 190,
    'b': 183,
    's': 11.5,
    't': 19,
    'r': 15,
    'kgm': 69.8,
  },
  {
    'Nazwa': 'HE 180 M',
    'h': 200,
    'b': 186,
    's': 14.5,
    't': 24,
    'r': 15,
    'kgm': 88.9,
  },
  {
    'Nazwa': 'HE 200 A',
    'h': 190,
    'b': 200,
    's': 6.5,
    't': 10,
    'r': 18,
    'kgm': 42.3,
  },
  {
    'Nazwa': 'HE 200 B',
    'h': 200,
    'b': 200,
    's': 9,
    't': 15,
    'r': 18,
    'kgm': 61.3,
  },
  {
    'Nazwa': 'HE 200 C',
    'h': 210,
    'b': 203,
    's': 12,
    't': 20,
    'r': 18,
    'kgm': 81.9,
  },
  {
    'Nazwa': 'HE 200 M',
    'h': 220,
    'b': 206,
    's': 15,
    't': 25,
    'r': 18,
    'kgm': 103,
  },
  {
    'Nazwa': 'HE 220 A',
    'h': 210,
    'b': 220,
    's': 7,
    't': 11,
    'r': 18,
    'kgm': 50.5,
  },
  {
    'Nazwa': 'HE 220 B',
    'h': 220,
    'b': 220,
    's': 9.5,
    't': 16,
    'r': 18,
    'kgm': 71.5,
  },
  {
    'Nazwa': 'HE 220 C',
    'h': 230,
    'b': 223,
    's': 12.5,
    't': 21,
    'r': 18,
    'kgm': 94.1,
  },
  {
    'Nazwa': 'HE 220 M',
    'h': 240,
    'b': 226,
    's': 15.5,
    't': 26,
    'r': 18,
    'kgm': 117,
  },
  {
    'Nazwa': 'HE 240 A',
    'h': 230,
    'b': 240,
    's': 7.5,
    't': 12,
    'r': 21,
    'kgm': 60.3,
  },
  {
    'Nazwa': 'HE 240 B',
    'h': 240,
    'b': 240,
    's': 10,
    't': 17,
    'r': 21,
    'kgm': 83.2,
  },
  {
    'Nazwa': 'HE 240 C',
    'h': 255,
    'b': 244,
    's': 14,
    't': 24.5,
    'r': 21,
    'kgm': 119.5,
  },
  {
    'Nazwa': 'HE 240 M',
    'h': 270,
    'b': 248,
    's': 18,
    't': 32,
    'r': 21,
    'kgm': 157,
  },
  {
    'Nazwa': 'HE 260 A',
    'h': 250,
    'b': 260,
    's': 7.5,
    't': 12.5,
    'r': 24,
    'kgm': 68.2,
  },
  {
    'Nazwa': 'HE 260 B',
    'h': 260,
    'b': 260,
    's': 10,
    't': 17.5,
    'r': 24,
    'kgm': 93,
  },
  {
    'Nazwa': 'HE 260 C',
    'h': 275,
    'b': 264,
    's': 14,
    't': 25,
    'r': 24,
    'kgm': 132.2,
  },
  {
    'Nazwa': 'HE 260 M',
    'h': 290,
    'b': 268,
    's': 18,
    't': 32.5,
    'r': 24,
    'kgm': 172,
  },
  {
    'Nazwa': 'HE 280 A',
    'h': 270,
    'b': 280,
    's': 8,
    't': 13,
    'r': 24,
    'kgm': 76.4,
  },
  {
    'Nazwa': 'HE 280 B',
    'h': 280,
    'b': 280,
    's': 10.5,
    't': 18,
    'r': 24,
    'kgm': 103,
  },
  {
    'Nazwa': 'HE 280 C',
    'h': 295,
    'b': 284,
    's': 14.5,
    't': 25.5,
    'r': 24,
    'kgm': 145.3,
  },
  {
    'Nazwa': 'HE 280 M',
    'h': 310,
    'b': 288,
    's': 18.5,
    't': 33,
    'r': 24,
    'kgm': 189,
  },
  {
    'Nazwa': 'HE 300 A',
    'h': 290,
    'b': 300,
    's': 8.5,
    't': 14,
    'r': 27,
    'kgm': 88.3,
  },
  {
    'Nazwa': 'HE 300 B',
    'h': 300,
    'b': 300,
    's': 11,
    't': 19,
    'r': 27,
    'kgm': 117,
  },
  {
    'Nazwa': 'HE 300 C',
    'h': 320,
    'b': 305,
    's': 16,
    't': 29,
    'r': 27,
    'kgm': 177,
  },
  {
    'Nazwa': 'HE 300 M',
    'h': 340,
    'b': 310,
    's': 21,
    't': 39,
    'r': 27,
    'kgm': 238,
  },
  {
    'Nazwa': 'HE 320 A',
    'h': 310,
    'b': 300,
    's': 9,
    't': 15.5,
    'r': 27,
    'kgm': 97.6,
  },
  {
    'Nazwa': 'HE 320 B',
    'h': 320,
    'b': 300,
    's': 11.5,
    't': 20.5,
    'r': 27,
    'kgm': 127,
  },
  {
    'Nazwa': 'HE 320 C',
    'h': 340,
    'b': 305,
    's': 16,
    't': 30.5,
    'r': 27,
    'kgm': 186,
  },
  {
    'Nazwa': 'HE 320 M',
    'h': 359,
    'b': 309,
    's': 21,
    't': 40,
    'r': 27,
    'kgm': 245,
  },
];
