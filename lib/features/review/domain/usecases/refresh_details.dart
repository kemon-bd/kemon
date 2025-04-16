import '../../../../core/shared/shared.dart';
import '../../review.dart';

class RefreshReviewDetailsUseCase {
  final ReviewRepository repository;

  RefreshReviewDetailsUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, ReviewDetailsEntity>> call({
    required Identity review,
  }) async {
    return await repository.refreshDetails(review: review);
  }
}
