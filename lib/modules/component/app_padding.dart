import 'package:flutter/material.dart';

class AppPadding extends StatelessWidget {
  const AppPadding({
    Key? key,
    required this.child,
    this.horizontal = 16,
    this.vertical = 0,
    this.paddingOnly = false,
    this.bottom = 0,
    this.left = 16,
    this.right = 16,
    this.top = 0,
  }) : super(key: key);

  final Widget child;

  final double horizontal;
  final double vertical;
  final double bottom;
  final double left;
  final double right;
  final double top;
  final bool paddingOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: paddingOnly
          ? EdgeInsets.only(
              bottom: bottom,
              left: left,
              right: right,
              top: top,
            )
          : EdgeInsets.symmetric(
              horizontal: horizontal,
              vertical: vertical,
            ),
      child: child,
    );
  }
}
