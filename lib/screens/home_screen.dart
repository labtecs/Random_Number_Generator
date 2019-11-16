import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    final myControllerMin = TextEditingController();
    final myControllerMax = TextEditingController();
    String resultField = "";
    //Start Values
    int minValue = 0;
    int maxValue = 100;

    var pad = EdgeInsets.fromLTRB(10, 0, 10, 0);
    var rng = new Random();

    /*
  Generate the Random Number
   */
    void _getRandom() {
      try {
        setState(() {
          if (myControllerMin.text.isEmpty) {
            myControllerMin.text = "0";
          }
          if (myControllerMax.text.isEmpty) {
            myControllerMax.text = "100";
          }
          minValue = int.parse(myControllerMin.text);
          maxValue = int.parse(myControllerMax.text);
          if (maxValue < minValue) {
            maxValue = minValue + 1;
            myControllerMax.text = maxValue.toString();
          }
          resultField =
              (minValue + rng.nextInt(maxValue - minValue + 1)).toString();
        });
      } catch (e) {
        print("Error _getRandom");
        setState(() {
          resultField = "Error";
        });
      }
    }

    /*
  reset the Result to start Value
   */
    void resetResult() {
      setState(() {
        resultField = "0";
      });
    }

    void dispose() {
      //Clean up the controller when the widget is disposed
      myControllerMin.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Random Number Generator"),
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: pad,
              child: Text(
                "Max",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              padding: pad,
              child: TextFormField(
                controller: myControllerMin,
                keyboardType: TextInputType.number,
                style: Theme
                    .of(context)
                    .textTheme
                    .display1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: pad,
              child: Text(
                "Min",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              padding: pad,
              child: TextFormField(
                controller: myControllerMax,
                keyboardType: TextInputType.number,
                style: Theme
                    .of(context)
                    .textTheme
                    .display1,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: pad,
              child: Text(
                "Result:",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              child: ListTile(
                contentPadding: pad,
                leading: Text(
                  "$resultField", style: TextStyle(fontSize: 30),
                ),
                trailing: RaisedButton(
                    onPressed: () {
                      myControllerMin.text = "";
                      myControllerMax.text = "";
                      resetResult();
                    },
                    child: Text("Clear")),
              ),
            ),
            ListTile(
              contentPadding: pad,
              trailing: RaisedButton(
                onPressed: () {
                  _getRandom();
                },
                child: Text("Generate"),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _getRandom();
          },
          child: Icon(Icons.add),
        ),
      );
    }
  }