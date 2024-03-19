import 'package:calculator/service_layer/input_util.dart';
import 'package:calculator/service_layer/operation_resolver.dart';
import 'package:flutter/material.dart';

import '../stateful_widgets/stateful_calc.dart';

class CalculatorState extends State<StatefulCalculator> {
  String output = "";
  String generatedRawOperation = "";
  String displayOutput = "";

  final double baseButtonTextSize = 20.0;

  onPressed(String value) {
    try {
      if (value == "=") {
        displayOutput = OperationResolver()
            .consume(generatedRawOperation)
            .resolve()
            .toString();
        generatedRawOperation = displayOutput;
      } else if (value == "CLEAR") {
        displayOutput = "";
        generatedRawOperation = "";
        return;
      } else {
        generatedRawOperation += InputUtil.isNumber(value) ? value : ' $value ';
      }
    } catch (e) {
      throw Exception(e);
    }
    print(generatedRawOperation);

    setState(() {
      if (displayOutput.isNotEmpty) {
        output = displayOutput;
      } else {
        output = generatedRawOperation;
      }
      displayOutput = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
            alignment: Alignment.centerRight,
            padding:
                const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            child: Text(output,
                style: const TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                ))),
        const Expanded(
          child: Divider(),
        ),
        Column(children: [
          Row(children: [
            buildButton("7"),
            buildButton("8"),
            buildButton("9"),
            buildButton("/")
          ]),
          Row(children: [
            buildButton("4"),
            buildButton("5"),
            buildButton("6"),
            buildButton("X", baseButtonTextSize - 4)
          ]),
          Row(children: [
            buildButton("1"),
            buildButton("2"),
            buildButton("3"),
            buildButton("-", baseButtonTextSize + 10)
          ]),
          Row(children: [
            buildButton(".", baseButtonTextSize + 5),
            buildButton("+")
          ]),
          Row(children: [
            buildButton("CLEAR"),
            buildButton("="),
          ])
        ])
      ],
    ));
  }

  Widget buildButton(String btnVal, [double? fontSize]) {
    final ButtonStyle btnStyle = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 100),
        backgroundColor: Colors.yellow.shade50);
    double? evalFontSize = fontSize;
    evalFontSize ??= baseButtonTextSize;
    return Expanded(
      child: OutlinedButton(
        style: btnStyle,
        child: Text(
          btnVal,
          style: TextStyle(fontSize: evalFontSize, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          onPressed(btnVal);
        },
      ),
    );
  }
}
