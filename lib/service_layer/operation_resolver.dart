import 'package:calculator/service_layer/local_stack.dart';
import 'package:calculator/service_layer/reverse_polish_notation_evaluator.dart';

class OperationResolver {
  static final OperationResolver _instance = OperationResolver._internal();

  factory OperationResolver() {
    return _instance;
  }

  OperationResolver._internal();

  final LocalStack<String> operationContainer = LocalStack();
  final RPNEvaluator evaluator = RPNEvaluator();

  OperationResolver consume(String rawOperationStr) {
    try {
      List<String> parts = rawOperationStr.split(" ");
      //TODO should convert infix to postfix.
      operationContainer.clearStack();
      operationContainer.push(parts[0]);
      operationContainer.push(parts[2]);
      operationContainer.push(parts[1]);
    } catch (e) {
      //temporary bail
    }
    return this;
  }

  bool shouldResolve() {
    return operationContainer.isAtLeastThreeElements();
  }

  void undo() {
    operationContainer.pop();
  }

  void undoAll() {
    operationContainer.clearStack();
  }

  double resolve() {
    return evaluator.autoResolve(operationContainer);
  }
}
