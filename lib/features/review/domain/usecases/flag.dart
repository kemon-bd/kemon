import '../../../../core/shared/shared.dart';
import '../../review.dart';

class FlagAReviewUseCase {
  final ReviewRepository repository;

  FlagAReviewUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required Identity review,
    required String? reason,
  }) async {
    return await repository.flag(review: review, reason: reason);
  }
}
