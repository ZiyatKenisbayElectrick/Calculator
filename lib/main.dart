import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationFontSize = 38.0;
        resultFontSize = 48.0;
      } else if (buttonText == "⌫") {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        equationFontSize = 38.0;
        resultFontSize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationFontSize = 48.0;
        resultFontSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Expanded(
      child: Container(
        height: 100,
        color: buttonColor,
        child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
                side: BorderSide(
                    color: Colors.white, width: 1, style: BorderStyle.solid)),
            padding: EdgeInsets.all(16.0),
            onPressed: () => buttonPressed(buttonText),
            child: Text(
              buttonText,
              style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
            child: Text(
          'Simple Calculator',
          style: TextStyle(color: Colors.black),
        )),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  // width: 170,
                  child: Table(
                    children: [
                      TableRow(children: [
                        buildButton("C", 1, Colors.grey),
                        buildButton("⌫", 1, Colors.grey),
                        buildButton("÷", 1, Colors.grey),
                      ]),
                      TableRow(children: [
                        buildButton("7", 1, Colors.black),
                        buildButton("8", 1, Colors.black),
                        buildButton("9", 1, Colors.black),
                      ]),
                      TableRow(children: [
                        buildButton("4", 1, Colors.black),
                        buildButton("5", 1, Colors.black),
                        buildButton("6", 1, Colors.black),
                      ]),
                      TableRow(children: [
                        buildButton("1", 1, Colors.black),
                        buildButton("2", 1, Colors.black),
                        buildButton("3", 1, Colors.black),
                      ]),
                      TableRow(children: [
                        buildButton(".", 1, Colors.black),
                        buildButton("0", 1, Colors.black),
                        buildButton("00", 1, Colors.black),
                      ]),
                    ],
                  ),
                ),
              ),
              Container(
                width: 100,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildButton("-", 1, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildButton("=", 1, Colors.grey),
                    ]),
                    TableRow(children: [
                      buildButton("%", 1, Colors.grey),
                    ]),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
