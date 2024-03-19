class LocalStack<T> {
  final listSimulator = <T>[];

  void push(T value) {
    listSimulator.add(value);
  }

  T pop() {
    return listSimulator.removeLast();
  }

  T peek() {
    return listSimulator.last;
  }

  bool isEmpty() {
    return listSimulator.isEmpty;
  }

  bool isAtLeastThreeElements() {
    return listSimulator.length >= 3;
  }

  void clearStack() {
    while (listSimulator.isNotEmpty) {
      listSimulator.removeLast();
    }
  }
}
