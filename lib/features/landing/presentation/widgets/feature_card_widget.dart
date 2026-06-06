import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../global/design_system/app_colors.dart';
import '../../../../global/design_system/app_spacing.dart';
import '../../../../global/design_system/app_typography.dart';
import '../../domain/entity/feature_card.dart';

class FeatureCardWidget extends StatelessWidget {
  const FeatureCardWidget({super.key, required this.card});

  final FeatureCard card;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.xs,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.base,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.greyDark.withAlpha(80), width: 0.5),
      ),
      child: Row(
        children: [
          _IconBox(iconPath: card.iconPath, bgColor: Color(card.iconBgColor)),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(card.title, style: AppTypography.cardTitle),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  card.subtitle,
                  style: AppTypography.cardSubtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IconBox extends StatelessWidget {
  const _IconBox({required this.iconPath, required this.bgColor});

  final String iconPath;
  final Color bgColor;

  static const _icons = {
    'assets/images/ic_single_tap.png': FontAwesomeIcons.handPointer,
    'assets/images/ic_zero_failures.png': FontAwesomeIcons.nfcSymbol,
    'assets/images/ic_refunds.png': FontAwesomeIcons.arrowsRotate,
  };

  @override
  Widget build(BuildContext context) {
    final icon = _icons[iconPath] ?? FontAwesomeIcons.circleCheck;
    return Container(
      width: AppSpacing.featureIconBoxSize,
      height: AppSpacing.featureIconBoxSize,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppSpacing.iconBoxRadius),
      ),
      child: Center(child: FaIcon(icon, color: AppColors.white, size: 22)),
    );
  }
}
