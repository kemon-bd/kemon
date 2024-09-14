import '../../../../core/shared/shared.dart';
import '../../review.dart';

class ReviewLocalDataSourceImpl extends ReviewLocalDataSource {
  final Map<String, List<ReviewEntity>> _cache = {};
  final Map<String, RatingEntity> _cacheRating = {};

  @override
  FutureOr<void> addAll({
    required String key,
    required List<ReviewEntity> reviews,
  }) {
    _cache[key] = reviews;
  }

  @override
  FutureOr<void> addRating({
    required String urlSlug,
    required RatingEntity rating,
  }) {
    _cacheRating[urlSlug] = rating;
  }

  @override
  FutureOr<List<ReviewEntity>> find({
    required String key,
  }) {
    final reviews = _cache[key];

    if (reviews == null) {
      throw ReviewNotFoundInLocalCacheFailure();
    }
    return reviews;
  }

  @override
  FutureOr<RatingEntity> findRating({
    required String urlSlug,
  }) {
    final rating = _cacheRating[urlSlug];

    if (rating == null) {
      throw RatingNotFoundInLocalCacheFailure();
    }
    return rating;
  }

  @override
  FutureOr<void> remove({
    required String urlSlug,
  }) {
    _cache.remove(urlSlug);
    _cacheRating.remove(urlSlug);
  }

  @override
  FutureOr<void> removeAll() {
    _cache.clear();
    _cacheRating.clear();
  }

  @override
  FutureOr<void> update({
    required String key,
    required ReviewEntity review,
  }) {
    final index = _cache[key]?.indexWhere(
          (r) => r.identity.guid.like(text: review.identity.guid),
        ) ??
        -1;
    if (!index.isNegative) {
      _cache[key]![index] = review;
    }
  }
}
