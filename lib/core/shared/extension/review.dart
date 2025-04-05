import '../shared.dart';

import '../../../features/review/review.dart';

extension ReviewCoreEntityExtension on ReviewCoreEntity {
  ReviewCoreEntity copyWith({
    int? rating,
    String? title,
    String? description,
    List<String>? photos,
    DateTime? experiencedAt,
  }) =>
      ReviewCoreEntity(
        identity: identity,
        star: rating ?? star,
        summary: title ?? summary,
        content: description ?? content,
        experiencedAt: experiencedAt ?? this.experiencedAt,
        reviewedAt: DateTime.now(),
        liked: liked,
        disliked: disliked,
        likes: likes,
        dislikes: dislikes,
        localGuide: localGuide,
      );
}

extension ReviewListExtension on List<ListingReviewEntity> {
  bool hasMyReview({
    required String userGuid,
  }) {
    return any((review) => review.reviewer.identity.guid.same(as: userGuid));
  }

  List<ReviewCoreEntity> filter({
    required List<int> options,
  }) {
    if (options.isEmpty) return this;
    return where((review) => options.contains(review.star)).toList();
  }
}

extension ListingReviewEntityExtension on ListingReviewEntity {
  bool myReview({
    required String me,
  }) {
    return reviewer.identity.guid.same(as: me);
  }
}

extension ReviewModelExtension on ReviewCoreModel {}
