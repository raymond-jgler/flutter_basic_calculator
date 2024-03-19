import 'package:flutter/material.dart';

import '../presentation_layer/calculator_widget_gateway.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorWidgetGateway(title: 'Basic Calculator'),
    );
  }
}
