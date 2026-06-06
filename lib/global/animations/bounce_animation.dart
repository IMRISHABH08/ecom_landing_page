import 'package:flutter/material.dart';

class BounceAnimation extends StatelessWidget {
  const BounceAnimation({
    super.key,
    required this.animation,
    required this.child,
  });

  final Animation<double> animation;
  final Widget child;

  static Animation<double> of(
    AnimationController controller, {
    Interval? interval,
  }) {
    final curved = CurvedAnimation(
      parent: controller,
      curve: interval ?? const Interval(0.0, 1.0),
    );
    return Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: curved, curve: Curves.elasticOut));
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(scale: animation, child: child);
  }
}
