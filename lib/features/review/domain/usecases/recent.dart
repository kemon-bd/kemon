import '../../../../core/shared/shared.dart';
import '../../review.dart';

class RecentReviewsUseCase {
  final ReviewRepository repository;

  RecentReviewsUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<ReviewEntity>>> call() async {
    return await repository.recent();
  }
}
