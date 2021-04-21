import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:expensetracker/analyze.dart';
import 'package:gsheets/gsheets.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _credentials = {};
  final _sheetid = "";
  final grocery = TextEditingController();
  final gas = TextEditingController();
  final bills = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void firstcheck(gro, ga, bil) async {
    final gsheets = GSheets(_credentials);
    final ss = await gsheets.spreadsheet(_sheetid);
    var sheet = ss.worksheetByTitle('Sheet1');

    Future<String> gsum = sheet.values.value(column: 1, row: 2);
    String grocerysum = await gsum;
    int allgsum = int.parse(grocerysum) + int.parse(gro);
    await sheet.values.insertValue(allgsum, column: 1, row: 2);

    Future<String> gasum = sheet.values.value(column: 2, row: 2);
    String gasSum = await gasum;
    int allgasum = int.parse(gasSum) + int.parse(ga);
    await sheet.values.insertValue(allgasum, column: 2, row: 2);

    Future<String> bsum = sheet.values.value(column: 3, row: 2);
    String billsum = await bsum;
    int allbillsum = int.parse(billsum) + int.parse(bil);
    await sheet.values.insertValue(allbillsum, column: 3, row: 2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(""),
        elevation: 0,
      ),
      drawer: Drawer(
        elevation: 15.0,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text("Expense Tracker"),
              decoration: BoxDecoration(
                color: Colors.blue[100],
              ),
            ),
            ListTile(
              title: Text("Analyze"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Analyze()));
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg_1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 58.0),
              child: GlassContainer(
                height: 100,
                width: 350,
                gradient: LinearGradient(
                  colors: [Colors.white.withOpacity(0.40), Colors.white.withOpacity(0.10)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderGradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.60),
                    Colors.white.withOpacity(0.10),
                    Colors.lightBlueAccent.withOpacity(0.05),
                    Colors.lightBlueAccent.withOpacity(0.6)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.0, 0.39, 0.40, 1.0],
                ),
                blur: 15.0,
                borderRadius: BorderRadius.circular(24.0),
                borderWidth: 1.5,
                elevation: 3.0,
                isFrostedGlass: true,
                shadowColor: Colors.black.withOpacity(0.20),
                alignment: Alignment.center,
                frostedOpacity: 0.12,
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Expense Tracker",
                  style: TextStyle(
                    fontSize: 45.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            GlassContainer(
              height: 230,
              width: 350,
              gradient: LinearGradient(
                colors: [Colors.white.withOpacity(0.40), Colors.white.withOpacity(0.10)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderGradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.60),
                  Colors.white.withOpacity(0.10),
                  Colors.lightBlueAccent.withOpacity(0.05),
                  Colors.lightBlueAccent.withOpacity(0.6)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.39, 0.40, 1.0],
              ),
              blur: 15.0,
              borderRadius: BorderRadius.circular(24.0),
              borderWidth: 1.5,
              elevation: 3.0,
              isFrostedGlass: true,
              shadowColor: Colors.black.withOpacity(0.20),
              alignment: Alignment.center,
              frostedOpacity: 0.12,
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: grocery,
                    decoration: InputDecoration(
                      labelText: "Grocery",
                      labelStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: gas,
                    decoration: InputDecoration(
                      labelText: "Gas",
                      labelStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextField(
                    controller: bills,
                    decoration: InputDecoration(
                      labelText: "Utility Bills",
                      labelStyle: TextStyle(color: Colors.white),
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 3.0,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
                onPressed: () {
                  firstcheck(grocery.text, gas.text, bills.text);
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.white,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
