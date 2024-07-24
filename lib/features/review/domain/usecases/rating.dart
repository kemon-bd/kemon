import '../../../../core/shared/shared.dart';
import '../../review.dart';

class FindRatingUseCase {
  final ReviewRepository repository;

  FindRatingUseCase({
    required this.repository,
  });

  Future<Either<Failure, RatingEntity>> call({
    required String urlSlug,
  }) async {
    return await repository.rating(urlSlug: urlSlug);
  }
}
