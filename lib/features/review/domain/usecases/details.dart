import '../../../../core/shared/shared.dart';
import '../../review.dart';

class FindReviewDetailsUseCase {
  final ReviewRepository repository;

  FindReviewDetailsUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, ReviewDetailsEntity>> call({
    required Identity review,
  }) async {
    return await repository.details(review: review);
  }
}
