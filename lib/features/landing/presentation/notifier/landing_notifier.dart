import 'package:flutter/foundation.dart';
import '../../domain/usecase/get_landing_config.dart';
import 'landing_state.dart';

class LandingNotifier extends ChangeNotifier {
  LandingNotifier(this._getLandingConfig) {
    _load();
  }

  final LandingConfigUsecase _getLandingConfig;

  LandingState _state = const LandingLoading();
  LandingState get state => _state;

  void _load() {
    final config = _getLandingConfig();
    _state = LandingLoaded(config);
    notifyListeners();
  }
}
