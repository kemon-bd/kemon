import '../../../../core/shared/shared.dart';
import '../../review.dart';

abstract class ReviewRepository {
  FutureOr<Either<Failure, void>> create({
    required Identity listing,
    required double rating,
    required String title,
    required String description,
    required String date,
    required List<XFile> attachments,
  });

  FutureOr<Either<Failure, void>> delete({
    required Identity review,
  });

  FutureOr<Either<Failure, List<UserReviewEntity>>> find({
    required Identity user,
    required bool refresh,
  });

  FutureOr<Either<Failure, void>> update({
    required ReviewCoreEntity review,
    required List<String> photos,
    required List<XFile> attachments,
  });

  FutureOr<Either<Failure, void>> react({
    required Identity review,
    required Reaction reaction,
    required Identity listing,
  });

  FutureOr<Either<Failure, void>> flag({
    required Identity review,
    required String? reason,
  });

  FutureOr<Either<Failure, ReviewDetailsEntity>> details({
    required Identity review,
  });

  FutureOr<Either<Failure, ReviewDetailsEntity>> refreshDetails({
    required Identity review,
  });

  FutureOr<Either<Failure, List<ReactionEntity>>> reactions({
    required Identity review,
  });
}
