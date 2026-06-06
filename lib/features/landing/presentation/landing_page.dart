import 'package:flutter/material.dart';
import '../../../global/design_system/app_colors.dart';
import '../../../global/design_system/app_spacing.dart';
import '../../../global/design_system/app_typography.dart';
import '../../../global/animations/staggered_animation.dart';
import '../domain/entity/landing_config.dart';
import 'notifier/landing_notifier.dart';
import 'notifier/landing_state.dart';
import 'sections/cta_section.dart';
import 'sections/feature_cards_section.dart';
import 'sections/marquee_section.dart';
import 'widgets/confetti_overlay.dart';
import 'widgets/dot_texture_painter.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key, required this.notifier});

  final LandingNotifier notifier;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late final AnimationController _navController;
  late final AnimationController _moveController;
  late final AnimationController _textController;
  late final AnimationController _scaleController;
  late final AnimationController _contentController;

  late final Animation<double> _iconScale;
  late final Animation<double> _iconRotation;
  late final Animation<double> _moveProgress;
  late final Animation<double> _textureOpacity;

  static const double _iconSize = 100.0;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _contentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _navController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _iconScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _iconRotation =
        TweenSequence<double>([
          TweenSequenceItem(tween: Tween(begin: 0.0, end: -0.07), weight: 1),
          TweenSequenceItem(tween: Tween(begin: -0.07, end: 0.07), weight: 2),
          TweenSequenceItem(tween: Tween(begin: 0.07, end: 0.0), weight: 1),
        ]).animate(
          CurvedAnimation(
            parent: _scaleController,
            curve: const Interval(0.55, 1.0, curve: Curves.easeInOut),
          ),
        );

    _moveProgress = CurvedAnimation(
      parent: _moveController,
      curve: Curves.easeInOutCubic,
    );

    _textureOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _moveController, curve: const Interval(0.3, 1.0)),
    );

    _playSequence();
  }

  Future<void> _playSequence() async {
    await Future.delayed(const Duration(milliseconds: 150));
    if (!mounted) return;

    _scaleController.forward();
    await Future.delayed(const Duration(milliseconds: 750));
    if (!mounted) return;

    _moveController.forward();

    _navController.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;

    _textController.forward();
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    _contentController.forward();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _moveController.dispose();
    _textController.dispose();
    _contentController.dispose();
    _navController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: ListenableBuilder(
        listenable: widget.notifier,
        builder: (context, _) {
          final state = widget.notifier.state;
          if (state is! LandingLoaded) return const SizedBox.shrink();
          final config = state.config;

          return LayoutBuilder(
            builder: (context, constraints) {
              final statusBarH = MediaQuery.of(context).padding.top;
              final screenH = constraints.maxHeight;
              final screenW = constraints.maxWidth;
              final iconFinalTop = statusBarH + AppSpacing.base;
              final iconCenterTop = (screenH - _iconSize) / 2;
              final iconCenterLeft = (screenW - _iconSize) / 2;

              return Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: AppColors.backgroundGradient,
                      ),
                    ),
                  ),

                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _textureOpacity,
                      builder: (_, __) => Opacity(
                        opacity: _textureOpacity.value,
                        child: const CustomPaint(painter: DotTexturePainter()),
                      ),
                    ),
                  ),

                  const Positioned.fill(child: ConfettiOverlay()),

                  AnimatedBuilder(
                    animation: _moveProgress,
                    builder: (_, child) {
                      final t = _moveProgress.value;
                      final contentTop =
                          iconFinalTop + _iconSize + AppSpacing.md;
                      final offset = (1 - t) * (iconCenterTop - iconFinalTop);
                      return Positioned(
                        top: contentTop + offset,
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Opacity(
                          opacity: t.clamp(0.0, 1.0),
                          child: child!,
                        ),
                      );
                    },
                    child: _ContentColumn(
                      config: config,
                      textController: _textController,
                      contentController: _contentController,
                    ),
                  ),

                  AnimatedBuilder(
                    animation: Listenable.merge([
                      _scaleController,
                      _moveController,
                    ]),
                    builder: (_, __) {
                      final t = _moveProgress.value;
                      final top = _lerp(iconCenterTop, iconFinalTop, t);
                      final left = iconCenterLeft;

                      return Positioned(
                        top: top,
                        left: left,
                        width: _iconSize,
                        height: _iconSize,
                        child: Transform.rotate(
                          angle: _iconRotation.value,
                          child: ScaleTransition(
                            scale: _iconScale,
                            child: const _WalletIcon(),
                          ),
                        ),
                      );
                    },
                  ),

                  Positioned(
                    top: statusBarH + AppSpacing.xs,
                    left: AppSpacing.sm,
                    child: StaggeredAnimation(
                      controller: _navController,
                      begin: 0.0,
                      end: 1.0,
                      slideOffset: const Offset(-0.3, 0),
                      child: _NavButton(
                        icon: Icons.arrow_back_ios_new_rounded,
                        onTap: () => Navigator.maybePop(context),
                      ),
                    ),
                  ),
                  Positioned(
                    top: statusBarH + AppSpacing.xs,
                    right: AppSpacing.sm,
                    child: StaggeredAnimation(
                      controller: _navController,
                      begin: 0.3,
                      end: 1.0,
                      slideOffset: const Offset(0.3, 0),
                      child: _NavButton(
                        icon: Icons.settings_outlined,
                        onTap: () {},
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _ContentColumn extends StatelessWidget {
  const _ContentColumn({
    required this.config,
    required this.textController,
    required this.contentController,
  });

  final LandingConfig config;
  final AnimationController textController;
  final AnimationController contentController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StaggeredAnimation(
          controller: textController,
          begin: 0.0,
          end: 0.5,
          slideOffset: const Offset(0, 0.3),
          child: Text(config.tagline, style: AppTypography.brandSmall),
        ),
        const SizedBox(height: AppSpacing.xxs),
        StaggeredAnimation(
          controller: textController,
          begin: 0.15,
          end: 0.7,
          slideOffset: const Offset(0, 0.3),
          child: Text(config.brandName, style: AppTypography.brandLarge),
        ),

        const SizedBox(height: AppSpacing.lg),

        Expanded(
          child: FeatureCardsSection(
            cards: config.featureCards,
            controller: contentController,
          ),
        ),

        StaggeredAnimation(
          controller: contentController,
          begin: 0.5,
          end: 1.0,
          slideOffset: const Offset(0, 0.2),
          child: CtaSection(
            ctaLabel: config.ctaLabel,
            giftCardLabel: config.giftCardLabel,
            giftCardSubtitle: config.giftCardSubtitle,
          ),
        ),

        StaggeredAnimation(
          controller: contentController,
          begin: 0.7,
          end: 1.0,
          slideOffset: const Offset(0, 0.1),
          child: MarqueeSection(text: config.marqueeText),
        ),
      ],
    );
  }
}

class _WalletIcon extends StatelessWidget {
  const _WalletIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFD700), Color(0xFFF5A623), Color(0xFF4CAF50)],
          stops: [0.0, 0.6, 1.0],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.yellow.withAlpha(90),
            blurRadius: 28,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Center(
        child: Text(
          '₹',
          style: TextStyle(
            fontSize: 48,
            color: Colors.white,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.surface.withAlpha(180),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.white, size: 18),
      ),
    );
  }
}

double _lerp(double a, double b, double t) => a + (b - a) * t;
