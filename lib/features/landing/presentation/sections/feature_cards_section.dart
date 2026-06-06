import 'package:flutter/material.dart';
import '../../../../global/animations/staggered_animation.dart';
import '../../domain/entity/feature_card.dart';
import '../widgets/feature_card_widget.dart';

class FeatureCardsSection extends StatelessWidget {
  const FeatureCardsSection({
    super.key,
    required this.cards,
    required this.controller,
  });

  final List<FeatureCard> cards;
  final AnimationController controller;

  static const _intervals = [(0.0, 0.45), (0.2, 0.65), (0.4, 0.85)];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: cards
          .map(
            (card) => Flexible(
              child: StaggeredAnimation(
                controller: controller,
                begin: _intervals[cards.indexOf(card) % _intervals.length].$1,
                end: _intervals[cards.indexOf(card) % _intervals.length].$2,
                slideOffset: const Offset(0, 0.3),
                child: FeatureCardWidget(card: card),
              ),
            ),
          )
          .toList(),
    );
  }
}
