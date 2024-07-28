import '../../../../core/shared/shared.dart';
import '../../review.dart';

class FindListingReviewUseCase {
  final ReviewRepository repository;

  FindListingReviewUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<ReviewEntity>>> call({
    required String urlSlug,
  }) async {
    return await repository.reviews(urlSlug: urlSlug);
  }
}
