import 'package:flutter/material.dart';

class StaggeredAnimation extends StatelessWidget {
  const StaggeredAnimation({
    super.key,
    required this.controller,
    required this.begin,
    required this.end,
    required this.child,
    this.slideOffset = const Offset(0, 0.3),
  });

  final double end;
  final double begin;

  final Widget child;

  final Offset slideOffset;

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    final interval = CurvedAnimation(
      parent: controller,
      curve: Interval(begin, end, curve: Curves.easeOutCubic),
    );

    final fade = Tween<double>(begin: 0.0, end: 1.0).animate(interval);
    final slide = Tween<Offset>(
      begin: slideOffset,
      end: Offset.zero,
    ).animate(interval);

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(position: slide, child: child),
    );
  }
}
