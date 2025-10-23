import 'package:flutter/material.dart';

class SupportController {
  static final SupportController _instance = SupportController._internal();
  factory SupportController() => _instance;
  SupportController._internal();

  Offset supportPosition = const Offset(280, 700); // initial position

  bool isOpen = false;

  final List<VoidCallback> _listeners = [];

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void updatePosition(Offset newPosition) {
    supportPosition = newPosition;
    _notify();
  }

  void toggleOpen() {
    isOpen = !isOpen;
    _notify();
  }

  void _notify() {
    for (var listener in _listeners) {
      listener();
    }
  }
}
