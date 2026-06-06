import '../../domain/entity/landing_config.dart';
import 'feature_card_model.dart';

class LandingConfigModel extends LandingConfig {
  const LandingConfigModel({
    required super.brandName,
    required super.tagline,
    required super.featureCards,
    required super.marqueeText,
    required super.ctaLabel,
    required super.giftCardLabel,
    required super.giftCardSubtitle,
  });

  static LandingConfigModel get hardcoded => const LandingConfigModel(
    brandName: 'MONEY',
    tagline: 'blinkit',
    featureCards: [
      FeatureCardModel(
        title: 'Single tap payments',
        subtitle: 'Enjoy seamless payments without the wait for OTPs',
        iconPath: 'assets/images/ic_single_tap.png',
        iconBgColor: 0xFF1B2D45,
      ),
      FeatureCardModel(
        title: 'Zero failures',
        subtitle: 'Zero payment failures ensure you never miss an order',
        iconPath: 'assets/images/ic_zero_failures.png',
        iconBgColor: 0xFF1A3530,
      ),
      FeatureCardModel(
        title: 'Real-time refunds',
        subtitle:
            'No need to wait for refunds. Blinkit Money refunds are instant!',
        iconPath: 'assets/images/ic_refunds.png',
        iconBgColor: 0xFF3B2510,
      ),
    ],
    marqueeText: 'Enjoy seamless one tap payments  ·  ',
    ctaLabel: 'Add Money',
    giftCardLabel: 'Claim Gift Card',
    giftCardSubtitle: 'Enter gift card details to claim your gift card',
  );
}
