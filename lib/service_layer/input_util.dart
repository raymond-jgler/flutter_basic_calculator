class InputUtil {
  static bool isOperand(String str) {
    if (str == null) {
      return false;
    }
    final number = double.tryParse(str);
    return number != null;
  }

  static bool isOperator(String str) {
    return !isOperand(str);
  }
}
