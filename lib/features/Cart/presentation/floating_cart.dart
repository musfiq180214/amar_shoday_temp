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

  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    // Only one listener for the animation controller
    _animationController.addListener(() {
      if (mounted) {
        // ✅ Check if widget is still in the tree
        _controller.updatePosition(_animation.value);
      }
    });

    // Listen to controller changes
    _controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.removeListener(() {}); // optional: remove listener
    super.dispose();
  }

  Widget _buildCart() {
    return GestureDetector(
      onTap: widget.onTap ?? () {},
      child: Image.asset(
        "assets/empty.png",
        width: 60,
        height: 60,
        fit: BoxFit.contain,
      ),
    );
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

          _animation = Tween<Offset>(
            begin: _controller.cartPosition,
            end: Offset(dx, dy),
          ).animate(CurvedAnimation(
            parent: _animationController,
            curve: Curves.elasticOut,
          ));

          _animationController.forward(from: 0); // ✅ No new listener here
        },
        child: _buildCart(),
      ),
    );
  }
}
