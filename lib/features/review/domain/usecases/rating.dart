import '../../../../core/shared/shared.dart';
import '../../review.dart';

class FindRatingUseCase {
  final ReviewRepository repository;

  FindRatingUseCase({
    required this.repository,
  });

  Future<Either<Failure, RatingEntity>> call({
    required String urlSlug,
    bool refresh = false,
  }) async {
    return await repository.rating(urlSlug: urlSlug, refresh: refresh);
  }
}
