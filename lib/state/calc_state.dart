import 'package:calculator/service_layer/input_util.dart';
import 'package:calculator/service_layer/operation_resolver.dart';
import 'package:flutter/material.dart';

import '../stateful_widgets/stateful_calc.dart';

class CalculatorState extends State<StatefulCalculator> {
  String output = "";
  String generatedRawOperation = "";
  String displayOutput = "";
  final double baseButtonTextSize = 20.0;

  final OperationResolver _resolver = OperationResolver();

  onPressed(String value) {
    try {
      if (value == "=") {
        displayOutput = resolve();
        generatedRawOperation = displayOutput;
      } else if (value == "CLEAR") {
        displayOutput = "";
        generatedRawOperation = "";
        return;
      } else {
        if (!InputUtil.isNumber(value)) {
          _resolver.consume(generatedRawOperation);
          if (_resolver.shouldResolve()) {
            displayOutput = resolve();
            generatedRawOperation = displayOutput;
          } else {
            _resolver.undoAll();
          }
        }
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

  String resolve() {
    return _resolver.consume(generatedRawOperation).resolve().toString();
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
            buildButton("0"),
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

  Widget buildButton(String btnVal,
      [double? fontSize, bool isExpanded = true]) {
    double? evalFontSize = fontSize;
    evalFontSize ??= baseButtonTextSize;
    final ButtonStyle btnStyle = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 100),
        backgroundColor: Colors.yellow.shade50);

    final Widget outlinedButton = OutlinedButton(
      style: btnStyle,
      child: Text(
        btnVal,
        style: TextStyle(fontSize: evalFontSize, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        onPressed(btnVal);
      },
    );
    if (isExpanded) {
      return Expanded(child: outlinedButton);
    }
    return outlinedButton;
  }
}
