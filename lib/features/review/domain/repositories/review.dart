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

  Future<Either<Failure, RatingEntity>> rating({
    required String urlSlug,
  });

  FutureOr<Either<Failure, List<ReviewEntity>>> find({
    required Identity user,
  });

  FutureOr<Either<Failure, void>> update({
    required ReviewEntity review,
  });
}
