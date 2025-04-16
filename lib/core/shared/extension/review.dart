import '../../../features/business/business.dart';
import '../../../features/profile/profile.dart';
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

  int get reactions => likes + dislikes;
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

  UserReviewEntity convertToUserBasedReview({
    required BuildContext context,
  }) {
    final listing = context.business;
    return UserReviewEntity(
      identity: identity,
      star: star,
      summary: summary,
      content: content,
      reviewedAt: reviewedAt,
      liked: liked,
      disliked: disliked,
      likes: likes,
      dislikes: dislikes,
      listing: BusinessPreviewEntity(
        urlSlug: listing.urlSlug,
        name: listing.name,
        logo: listing.logo,
        verified: listing.verified,
      ),
      localGuide: localGuide,
      photos: photos,
      experiencedAt: experiencedAt,
    );
  }
}

extension UserReviewEntityExtension on UserReviewEntity {
  ListingReviewEntity convertToListingBasedReview({
    required BuildContext context,
  }) {
    final profile = context.auth.profile!;
    return ListingReviewEntity(
      identity: identity,
      star: star,
      summary: summary,
      content: content,
      reviewedAt: reviewedAt,
      liked: liked,
      disliked: disliked,
      likes: likes,
      dislikes: dislikes,
      reviewer: UserPreviewEntity(
        identity: profile.identity,
        name: profile.name,
        profilePicture: profile.profilePicture ?? '',
      ),
      localGuide: localGuide,
      photos: photos,
      experiencedAt: experiencedAt,
    );
  }
}

extension ReviewDetailsEntityExtension on ReviewDetailsEntity {
  ListingReviewEntity get convertToListingBasedReview {
    return ListingReviewEntity(
      identity: identity,
      star: star,
      summary: summary,
      content: content,
      reviewedAt: reviewedAt,
      liked: liked,
      disliked: disliked,
      likes: likes,
      dislikes: dislikes,
      reviewer: reviewer,
      localGuide: localGuide,
      photos: photos,
      experiencedAt: experiencedAt,
    );
  }
}
