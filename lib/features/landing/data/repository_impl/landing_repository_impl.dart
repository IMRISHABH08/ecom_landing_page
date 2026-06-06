import '../../domain/entity/landing_config.dart';
import '../../domain/repository/landing_repository.dart';
import '../model/landing_config_model.dart';

class LandingRepositoryImpl implements LandingRepository {
  @override
  LandingConfig getLandingConfig() => LandingConfigModel.hardcoded;
}
