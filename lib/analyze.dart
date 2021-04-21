import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:gsheets/gsheets.dart';

class Analyze extends StatefulWidget {
  @override
  _AnalyzeState createState() => _AnalyzeState();
}

class _AnalyzeState extends State<Analyze> {
  final _credentials = {};
  final _sheetid = "";

  double grocery;
  double gas;
  double bills;
  Map<String, double> myDataMap;

  @override
  void initState() {
    super.initState();
    getAllValues();
  }

  void getAllValues() async {
    final gsheets = GSheets(_credentials);
    final ss = await gsheets.spreadsheet(_sheetid);
    var sheet = ss.worksheetByTitle('Sheet1');

    String tempgrocery = await sheet.values.value(column: 1, row: 2);
    String tempgas = await sheet.values.value(column: 2, row: 2);
    String tempbills = await sheet.values.value(column: 3, row: 2);

    grocery = double.parse(tempgrocery);
    gas = double.parse(tempgas);
    bills = double.parse(tempbills);

    setState(() {
      myDataMap = {
        "Grocery": grocery,
        "Gas": gas,
        "Utility Bills": bills,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    if (myDataMap != null) {
      return Scaffold(
        body: Container(
          child: Center(
            child: PieChart(
              dataMap: myDataMap,
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }
  }
}
