import '../../../../core/shared/shared.dart';
import '../../review.dart';

class DeleteReviewUseCase {
  final ReviewRepository repository;

  DeleteReviewUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required Identity review,
  }) async {
    return await repository.delete(review: review);
  }
}
