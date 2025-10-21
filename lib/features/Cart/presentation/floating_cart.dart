// widgets/floating_cart.dart
import 'package:amar_shoday/features/Cart/controller/cart_controller.dart';
import 'package:flutter/material.dart';

class FloatingCart extends StatefulWidget {
  final void Function()? onTap;

  const FloatingCart({super.key, this.onTap});

  @override
  State<FloatingCart> createState() => _FloatingCartState();
}

class _FloatingCartState extends State<FloatingCart>
    with SingleTickerProviderStateMixin {
  final CartController _controller = CartController();

  late AnimationController _cartAnimationController;
  late Animation<Offset> _cartAnimation;

  @override
  void initState() {
    super.initState();

    _cartAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _cartAnimationController.addListener(() {
      _controller.cartPosition = _cartAnimation.value;
      setState(() {});
    });
  }

  @override
  void dispose() {
    _cartAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final position = _controller.cartPosition;

    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        feedback: _buildCart(),
        childWhenDragging: const SizedBox.shrink(),
        onDragEnd: (details) {
          double dx = details.offset.dx.clamp(0.0, screenSize.width - 60);
          double dy = details.offset.dy
              .clamp(0.0, screenSize.height - 60 - kBottomNavigationBarHeight);

          _cartAnimation = Tween<Offset>(
            begin: _controller.cartPosition,
            end: Offset(dx, dy),
          ).animate(
            CurvedAnimation(
              parent: _cartAnimationController,
              curve: Curves.elasticOut,
            ),
          );

          _cartAnimationController.forward(from: 0);
        },
        child: _buildCart(),
      ),
    );
  }

  // 🔹 Make sure this method exists inside the class
  Widget _buildCart() {
    return GestureDetector(
      onTap: widget.onTap ??
          () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Cart tapped!")),
            );
          },
      child: Image.asset(
        "assets/empty.png",
        width: 60,
        height: 60,
        fit: BoxFit.contain,
      ),
    );
  }
}
