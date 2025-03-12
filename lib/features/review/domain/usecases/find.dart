import '../../../../core/shared/shared.dart';
import '../../review.dart';

class FindUserReviewsUseCase {
  final ReviewRepository repository;

  FindUserReviewsUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<UserReviewEntity>>> call({
    required Identity user,
    bool refresh = false,
  }) async {
    return await repository.find(user: user, refresh: refresh);
  }
}
