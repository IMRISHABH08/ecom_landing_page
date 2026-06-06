import '../entity/landing_config.dart';
import '../repository/landing_repository.dart';

abstract class LandingConfigUsecase {
  LandingConfig call();
}

class LandingConfigUsecaseImpl implements LandingConfigUsecase {
  const LandingConfigUsecaseImpl(this._repository);

  final LandingRepository _repository;

  @override
  LandingConfig call() => _repository.getLandingConfig();
}
