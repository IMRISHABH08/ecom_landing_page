import 'package:flutter/material.dart';
import '../../../../global/animations/marquee_animation.dart';
import '../../../../global/design_system/app_colors.dart';
import '../../../../global/design_system/app_spacing.dart';
import '../../../../global/design_system/app_typography.dart';

class MarqueeSection extends StatelessWidget {
  const MarqueeSection({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [AppColors.yellow, AppColors.green],
        ).createShader(bounds),
        child: MarqueeAnimation(
          text: text,
          style: AppTypography.marqueeText,
          height: 36,
          velocity: 50.0,
          gap: 60.0,
        ),
      ),
    );
  }
}
