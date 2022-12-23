import 'dart:developer';

import 'package:e_book_app/index.dart';

class AppAnimatedIcon extends StatefulWidget {
  const AppAnimatedIcon({
    super.key,
    required this.icon1,
    required this.icon2,
    this.animated = false,
    required this.onChanged,
  });

  final IconData icon1;
  final IconData icon2;
  final bool animated;
  final ValueChanged<bool> onChanged;

  @override
  State<AppAnimatedIcon> createState() => _AppAnimatedIconState();
}

class _AppAnimatedIconState extends State<AppAnimatedIcon> {
  IconData get _icon1 => widget.icon1;
  IconData get _icon2 => widget.icon2;
  bool _animated = false;

  @override
  void initState() {
    super.initState();
    _animated = widget.animated;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 20,
      iconSize: 20,
      color: Theme.of(context).iconTheme.color,
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, anim) => RotationTransition(
          turns: child.key == const ValueKey('icon1')
              ? Tween<double>(begin: 1, end: 0.75).animate(anim)
              : Tween<double>(begin: 0.5, end: 1).animate(anim),
          child: ScaleTransition(
            scale: anim,
            child: child,
          ),
        ),
        child: _animated
            ? Icon(_icon1, key: const ValueKey('icon1'))
            : Icon(_icon2, key: const ValueKey('icon2')),
      ),
      onPressed: () {
        _animated = !_animated;
        widget.onChanged(_animated);
        setState(() {});
      },
    );
  }
}
