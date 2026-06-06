import '../../features/landing/data/repository_impl/landing_repository_impl.dart';
import '../../features/landing/domain/repository/landing_repository.dart';
import '../../features/landing/domain/usecase/get_landing_config.dart';
import '../../features/landing/presentation/notifier/landing_notifier.dart';

class ServiceLocator {
  ServiceLocator._();
  static final ServiceLocator _instance = ServiceLocator._();

  late final LandingRepository _repository = LandingRepositoryImpl();
  late final LandingConfigUsecase _usecase = LandingConfigUsecaseImpl(
    _repository,
  );
  late final LandingNotifier landingNotifier = LandingNotifier(_usecase);

  static T get<T extends Object>() => _instance._resolve<T>();

  T _resolve<T extends Object>() {
    if (T == LandingNotifier) return _instance.landingNotifier as T;
    if (T == LandingConfigUsecase) return _instance._usecase as T;
    if (T == LandingRepository) return _instance._repository as T;
    throw UnimplementedError('$T is not registered in ServiceLocator');
  }
}
