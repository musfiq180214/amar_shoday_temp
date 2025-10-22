// controllers/cart_controller.dart
import 'package:flutter/material.dart';

class CartController {
  static final CartController _instance = CartController._internal();
  factory CartController() => _instance;
  CartController._internal();

  // Current cart position
  Offset cartPosition = const Offset(300, 425);

  // Listeners for cart position changes
  final List<VoidCallback> _listeners = [];

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void updatePosition(Offset newPosition) {
    cartPosition = newPosition;
    for (var listener in _listeners) {
      listener();
    }
  }
}
