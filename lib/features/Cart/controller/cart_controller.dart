// controllers/cart_controller.dart
import 'package:flutter/material.dart';

class CartController {
  // Singleton instance
  static final CartController _instance = CartController._internal();

  factory CartController() => _instance;

  CartController._internal();

  // Current cart position
  Offset cartPosition = const Offset(300, 425);

  // Animation controller reference for smooth animation
  AnimationController? animationController;
}
