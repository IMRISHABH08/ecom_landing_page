import '../../domain/entity/landing_config.dart';

sealed class LandingState {
  const LandingState();
}

final class LandingLoading extends LandingState {
  const LandingLoading();
}

final class LandingLoaded extends LandingState {
  const LandingLoaded(this.config);

  final LandingConfig config;
}
