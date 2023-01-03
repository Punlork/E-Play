import 'package:flutter/material.dart';

class CustomIconWidget extends StatelessWidget {
  const CustomIconWidget({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = 20,
    this.splashRadius = 20,
    this.color,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double? size;
  final double? splashRadius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        color: color ?? Theme.of(context).iconTheme.color,
        splashRadius: splashRadius,
        iconSize: size,
      ),
    );
  }
}
