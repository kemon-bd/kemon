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

  int get five => where((review) => review.star == 5).length;
  int get four => where((review) => review.star == 4).length;
  int get three => where((review) => review.star == 3).length;
  int get two => where((review) => review.star == 2).length;
  int get one => where((review) => review.star == 1).length;
}

extension ReviewModelExtension on ReviewCoreModel {}