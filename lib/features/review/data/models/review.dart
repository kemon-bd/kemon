import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../profile/profile.dart';
import '../../review.dart';

class ReviewCoreModel extends ReviewCoreEntity {
  const ReviewCoreModel({
    required super.identity,
    required super.star,
    required super.summary,
    required super.content,
    required super.experiencedAt,
    required super.reviewedAt,
    required super.likes,
    required super.dislikes,
    required super.liked,
    required super.disliked,
    required super.localGuide,
  });

  factory ReviewCoreModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      return ReviewCoreModel(
        identity: Identity(id: map['id'], guid: map['guid']),
        star: map['star'],
        summary: map['summary'],
        content: parse(map['content']).body?.text ?? '',
        experiencedAt: DateTime.parse(map['experiencedAt']),
        reviewedAt: DateTime.parse(map['reviewedAt']),
        likes: map['likes'] ?? 0,
        dislikes: map['dislikes'] ?? 0,
        liked: map['liked'] ?? false,
        disliked: map['disliked'] ?? false,
        localGuide: map['localGuide'] ?? false,
      );
    } catch (e, stackTrace) {
      throw ReviewModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}

class RecentReviewModel extends RecentReviewEntity implements ReviewCoreEntity {
  const RecentReviewModel({
    required super.identity,
    required super.reviewer,
    required super.listing,
    required super.star,
    required super.summary,
    required super.content,
    required super.experiencedAt,
    required super.reviewedAt,
    required super.photos,
    required super.likes,
    required super.dislikes,
    required super.liked,
    required super.disliked,
    required super.localGuide,
  });

  factory RecentReviewModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final core = ReviewCoreModel.parse(map: map);
      final listing = map['listing'] ?? {};
      final reviewer = map['reviewer'] ?? {};
      return RecentReviewModel(
        identity: core.identity,
        star: core.star,
        summary: core.summary,
        content: core.content,
        experiencedAt: core.experiencedAt,
        reviewedAt: core.reviewedAt,
        likes: core.likes,
        dislikes: core.dislikes,
        liked: core.liked,
        disliked: core.disliked,
        localGuide: core.localGuide,
        photos: map['photos'],
        reviewer: UserPreviewModel.parse(map: reviewer),
        listing: BusinessPreviewModel.parse(map: listing),
      );
    } catch (e, stackTrace) {
      throw ReviewModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}

class ReviewDetailsModel extends ReviewDetailsEntity implements ReviewCoreEntity {
  const ReviewDetailsModel({
    required super.identity,
    required super.reviewer,
    required super.listing,
    required super.star,
    required super.summary,
    required super.content,
    required super.experiencedAt,
    required super.reviewedAt,
    required super.photos,
    required super.likes,
    required super.dislikes,
    required super.liked,
    required super.disliked,
    required super.localGuide,
  });

  factory ReviewDetailsModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final core = ReviewCoreModel.parse(map: map);
      final listing = map['listing'] ?? {};
      final reviewer = map['reviewer'] ?? {};
      return ReviewDetailsModel(
        identity: core.identity,
        star: core.star,
        summary: core.summary,
        content: core.content,
        experiencedAt: core.experiencedAt,
        reviewedAt: core.reviewedAt,
        likes: core.likes,
        dislikes: core.dislikes,
        liked: core.liked,
        disliked: core.disliked,
        localGuide: core.localGuide,
        photos: List<String>.from(map['photos'] ?? []),
        reviewer: UserPreviewModel.parse(map: reviewer),
        listing: BusinessPreviewModel.parse(map: listing),
      );
    } catch (e, stackTrace) {
      throw ReviewModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}

class ListingReviewModel extends ListingReviewEntity implements ReviewCoreEntity {
  const ListingReviewModel({
    required super.identity,
    required super.reviewer,
    required super.star,
    required super.summary,
    required super.content,
    required super.experiencedAt,
    required super.reviewedAt,
    required super.photos,
    required super.likes,
    required super.dislikes,
    required super.liked,
    required super.disliked,
    required super.localGuide,
  });

  factory ListingReviewModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final core = ReviewCoreModel.parse(map: map);
      final reviewer = map['reviewer'] ?? {};
      return ListingReviewModel(
        identity: core.identity,
        star: core.star,
        summary: core.summary,
        content: core.content,
        experiencedAt: core.experiencedAt,
        reviewedAt: core.reviewedAt,
        likes: core.likes,
        dislikes: core.dislikes,
        liked: core.liked,
        disliked: core.disliked,
        localGuide: core.localGuide,
        reviewer: UserPreviewModel.parse(map: reviewer),
        photos: List<String>.from(map['photos']).skipWhile((url) => url.isEmpty).toList(),
      );
    } catch (e, stackTrace) {
      throw ReviewModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}

class UserReviewModel extends UserReviewEntity implements ReviewCoreEntity {
  const UserReviewModel({
    required super.identity,
    required super.listing,
    required super.star,
    required super.summary,
    required super.content,
    required super.experiencedAt,
    required super.reviewedAt,
    required super.photos,
    required super.likes,
    required super.dislikes,
    required super.liked,
    required super.disliked,
    required super.localGuide,
  });

  factory UserReviewModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      final core = ReviewCoreModel.parse(map: map);
      final listing = map['listing'] ?? {};
      return UserReviewModel(
        identity: core.identity,
        star: core.star,
        summary: core.summary,
        content: core.content,
        experiencedAt: core.experiencedAt,
        reviewedAt: core.reviewedAt,
        likes: core.likes,
        dislikes: core.dislikes,
        liked: core.liked,
        disliked: core.disliked,
        localGuide: core.localGuide,
        photos: List<String>.from(map['photos']).skipWhile((url) => url.isEmpty).toList(),
        listing: BusinessPreviewModel.parse(map: listing),
      );
    } catch (e, stackTrace) {
      throw ReviewModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
