import '../../../../core/shared/shared.dart';
import '../../review.dart';

abstract class ReviewLocalDataSource {
  FutureOr<void> addRating({
    required String urlSlug,
    required RatingEntity rating,
  });

  FutureOr<void> addAll({
    required String key,
    required List<ReviewEntity> reviews,
  });

  FutureOr<void> update({
    required String key,
    required ReviewEntity review,
  });

  FutureOr<void> remove({
    required String urlSlug,
  });

  FutureOr<void> removeUser({
    required String user,
  });

  FutureOr<void> removeAll();

  FutureOr<List<ReviewEntity>> find({
    required String key,
  });

  FutureOr<RatingEntity> findRating({
    required String urlSlug,
  });
}
