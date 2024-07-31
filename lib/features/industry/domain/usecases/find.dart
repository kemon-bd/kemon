import '../../../../core/shared/shared.dart';
import '../../industry.dart';

class FindIndustryUseCase {
  final IndustryRepository repository;

  FindIndustryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, IndustryEntity>> call({
    required String urlSlug,
  }) async {
    return await repository.find(urlSlug: urlSlug);
  }
}
