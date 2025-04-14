import '../../../../core/shared/shared.dart';
import '../../location.dart';

class FindLocationDeeplinkUseCase {
  final LocationRepository repository;

  FindLocationDeeplinkUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, LocationEntity>> call({
    required String urlSlug,
  }) async {
    return await repository.deeplink(urlSlug: urlSlug);
  }
}
