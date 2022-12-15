import 'dart:collection';

import 'package:observer/observer.dart';

class ErrorService with Observable {
  final Queue<String> messageQueue = Queue<String>();

  // singleton implementation ...
  ErrorService();

  static ErrorService? instance;

  static void initialize() {
    instance = ErrorService();
  }

  static ErrorService get() {
    if (instance == null) {
      throw Exception("ErrorService not configured");
    }
    return instance!;
  }

  // ... ends here

  // queue access
  void _add(final String message) {
    messageQueue.add(message);
  }

  String _remove() {
    return messageQueue.removeFirst();
  }

  static void add(final String message) {
    instance!._add(message);
    instance!.notifyObservers(Object());
  }

  static String remove() {
    return instance!._remove();
  }
}
