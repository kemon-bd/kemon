import '../../../../core/shared/shared.dart';
import '../../review.dart';

class FindReviewReactionsUseCase {
  final ReviewRepository repository;

  FindReviewReactionsUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<ReactionEntity>>> call({
    required Identity review,
  }) async {
    return await repository.reactions(review: review);
  }
}
