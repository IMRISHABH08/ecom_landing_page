import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../resources/resources.dart';

class ConfettiOverlay extends StatelessWidget {
  const ConfettiOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Lottie.asset(Lotties.confetti, fit: BoxFit.cover, repeat: false),
    );
  }
}
