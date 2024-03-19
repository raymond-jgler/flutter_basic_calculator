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

  OperationResolver consume(String element) {
    List<String> words = element.split(" ");
    //TODO should convert infix to postfix.
    operationContainer.clearStack();
    operationContainer.push(words[0]);
    operationContainer.push(words[2]);
    operationContainer.push(words[1]);
    return this;
  }

  bool shouldResolve() {
    return operationContainer.isAtLeastThreeElements();
  }

  void undo() {
    operationContainer.pop();
  }

  double resolve() {
    return evaluator.autoResolve(operationContainer);
  }
}
