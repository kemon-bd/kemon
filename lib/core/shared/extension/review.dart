import '../shared.dart';

import '../../../features/review/review.dart';

extension ReviewEntityExtension on ReviewEntity {
  ReviewEntity copyWith({
    int? rating,
    String? title,
    String? description,
    List<String>? photos,
    DateTime? experiencedAt,
  }) =>
      ReviewEntity(
        identity: identity,
        user: user,
        listing: listing,
        rating: rating ?? this.rating,
        title: title ?? this.title,
        description: description ?? this.description,
        experiencedAt: experiencedAt ?? this.experiencedAt,
        reviewedAt: DateTime.now(),
        photos: photos ?? this.photos,
        deleted: deleted,
        flagged: flagged,
      );
}

extension ReviewListExtension on List<ReviewEntity> {
  bool hasMyReview({
    required String userGuid,
  }) {
    return any((review) => review.user.guid.same(as: userGuid));
  }

  List<ReviewEntity> filter({
    required List<int> options,
  }) {
    if (options.isEmpty) return this;
    return where((review) => options.contains(review.rating)).toList();
  }
}

extension RatingEntityExtension on RatingEntity {
  String get remarks {
    if (average > 4) {
      return "Excellent";
    } else if (average > 3) {
      return "Good";
    } else if (average > 2) {
      return "Fair";
    } else if (average > 1) {
      return "Poor";
    } else {
      return "Very Poor";
    }
  }

  double get average {
    final int totalRating = (5 * five) + (4 * four) + (3 * three) + (2 * two) + one;
    return total > 0 ? totalRating / total : 0;
  }
}

extension ReviewModelExtension on ReviewModel {}

extension ReactionEntitiesExtension on List<ReactionEntity> {
  bool iLiked({
    required Identity? identity,
  }) =>
      identity != null
          ? any(
              (r) => r.user.guid.same(as: identity.guid) && r.type == Reaction.like,
            )
          : false;
  bool iDisliked({
    required Identity? identity,
  }) =>
      identity != null
          ? any(
              (r) => r.user.guid.same(as: identity.guid) && r.type == Reaction.dislike,
            )
          : false;
  int get likes => where((r) => r.type == Reaction.like).length;
  int get dislikes => where((r) => r.type == Reaction.dislike).length;
}
