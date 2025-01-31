import '../../../../core/shared/shared.dart';
import '../../business.dart';

class ValidateUrlSlugUseCase {
  final BusinessRepository repository;

  ValidateUrlSlugUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({required String urlSlug}) async {
    return await repository.validateUrlSlug(urlSlug: urlSlug);
  }
}
