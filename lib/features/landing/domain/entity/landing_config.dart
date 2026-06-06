import 'feature_card.dart';

class LandingConfig {
  const LandingConfig({
    required this.brandName,
    required this.tagline,
    required this.featureCards,
    required this.marqueeText,
    required this.ctaLabel,
    required this.giftCardLabel,
    required this.giftCardSubtitle,
  });

  final String brandName;
  final String tagline;
  final List<FeatureCard> featureCards;
  final String marqueeText;
  final String ctaLabel;
  final String giftCardLabel;
  final String giftCardSubtitle;
}
