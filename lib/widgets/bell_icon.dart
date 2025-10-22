import 'package:flutter/material.dart';

class BellIconButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const BellIconButton({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: IconButton(
        icon: Image.asset(
          'assets/bell_icon.png',
          width: 40,
          height: 40,
        ),
        onPressed: onPressed ?? () {},
        iconSize: 15,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      ),
    );
  }
}
