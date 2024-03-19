import 'package:calculator/service_layer/operation_resolver.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return CalculatorState();
  }
}

class CalculatorState extends State<Calculator> {
  String output = "0";

  String generatedRawOperation = "";
  String displayOutput = "";
  String operand = "";

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
        generatedRawOperation +=
            generatedRawOperation.isNotEmpty ? ' $value' : value;
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
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(
                    vertical: 24.0, horizontal: 12.0),
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
                buildButton("X")
              ]),
              Row(children: [
                buildButton("1"),
                buildButton("2"),
                buildButton("3"),
                buildButton("-")
              ]),
              Row(children: [
                buildButton("."),
                buildButton("0"),
                buildButton("00"),
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
    evalFontSize ??= 20.0;
    return Expanded(
      child: OutlinedButton(
        style: btnStyle,
        child: Text(
          btnVal,
          style: TextStyle(fontSize: evalFontSize, fontWeight: FontWeight.bold),
        ),
        onPressed: () => onPressed(btnVal),
      ),
    );
  }
}
