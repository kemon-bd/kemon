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

  Color color({
    required ThemeScheme scheme,
  }) {
    switch (star) {
      case 5:
        return scheme.primary;
      case 4:
        return Colors.lime.shade700;
      case 3:
        return Colors.yellow.shade800;
      case 2:
        return Colors.orange.shade700;
      case 1:
        return Colors.red;
      default:
        return scheme.backgroundPrimary;
    }
  }
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
