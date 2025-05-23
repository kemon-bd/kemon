import '../../../../core/shared/shared.dart';
import '../../business.dart';

class FindBusinessUseCase {
  final BusinessRepository repository;

  FindBusinessUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, ListingEntity>> call({
    required String urlSlug,
    required List<int> filter,

  }) async {
    return await repository.find(urlSlug: urlSlug, filter: filter);
  }
}
