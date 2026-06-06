import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../global/design_system/app_colors.dart';
import '../../../../global/design_system/app_spacing.dart';
import '../../../../global/design_system/app_typography.dart';

class CtaSection extends StatefulWidget {
  const CtaSection({
    super.key,
    required this.ctaLabel,
    required this.giftCardLabel,
    required this.giftCardSubtitle,
    this.onCtaTap,
    this.onGiftCardTap,
  });

  final String ctaLabel;
  final String giftCardLabel;
  final String giftCardSubtitle;
  final VoidCallback? onCtaTap;
  final VoidCallback? onGiftCardTap;

  @override
  State<CtaSection> createState() => _CtaSectionState();
}

class _CtaSectionState extends State<CtaSection>
    with SingleTickerProviderStateMixin {
  late final Animation<double> _pulse;
  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _pulse = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.base),
      child: Column(
        children: [
          ScaleTransition(
            scale: _pulse,
            child: SizedBox(
              width: double.infinity,
              height: AppSpacing.ctaButtonHeight,
              child: ElevatedButton(
                onPressed: widget.onCtaTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  foregroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppSpacing.buttonRadius,
                    ),
                  ),
                  elevation: 0,
                ),
                child: Text(widget.ctaLabel, style: AppTypography.buttonLabel),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          _GiftCardRow(
            label: widget.giftCardLabel,
            subtitle: widget.giftCardSubtitle,
            onTap: widget.onGiftCardTap,
          ),
          const SizedBox(height: AppSpacing.xl),
        ],
      ),
    );
  }
}

class _GiftCardRow extends StatelessWidget {
  const _GiftCardRow({required this.label, required this.subtitle, this.onTap});

  final String label;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.base,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(
            color: AppColors.greyDark.withAlpha(80),
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.yellow.withAlpha(30),
                borderRadius: BorderRadius.circular(AppSpacing.sm),
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.gift,
                  color: AppColors.yellow,
                  size: 18,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTypography.rowTitle),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTypography.rowSubtitle),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.grey, size: 20),
          ],
        ),
      ),
    );
  }
}
