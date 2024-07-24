import '../../../../core/shared/shared.dart';
import '../../review.dart';

class UpdateReviewUseCase {
  final ReviewRepository repository;

  UpdateReviewUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required ReviewEntity review,
  }) async {
    return await repository.update(
      review: review,
    );
  }
}
