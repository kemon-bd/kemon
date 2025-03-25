import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../profile/profile.dart';

class ReviewCoreEntity extends Equatable {
  final Identity identity;
  final int star;
  final String summary;
  final String content;
  final DateTime experiencedAt;
  final DateTime reviewedAt;
  final int likes;
  final int dislikes;
  final bool liked;
  final bool disliked;

  const ReviewCoreEntity({
    required this.identity,
    required this.star,
    required this.summary,
    required this.content,
    required this.experiencedAt,
    required this.reviewedAt,
    required this.likes,
    required this.dislikes,
    required this.liked,
    required this.disliked,
  });

  @override
  List<Object?> get props => [
        identity,
        star,
        summary,
        content,
        experiencedAt,
        reviewedAt,
        likes,
        dislikes,
        liked,
        disliked,
      ];
}

class RecentReviewEntity extends ReviewCoreEntity {
  final int photos;
  final BusinessPreviewEntity listing;
  final UserPreviewEntity reviewer;
  const RecentReviewEntity({
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
    required this.listing,
    required this.reviewer,
    required this.photos,
  });

  @override
  List<Object?> get props => [
        listing,
        identity,
        reviewer,
        star,
        summary,
        content,
        experiencedAt,
        reviewedAt,
        photos,
        likes,
        dislikes,
        liked,
        disliked,
      ];
}

class ListingReviewEntity extends ReviewCoreEntity {
  final List<String> photos;
  final UserPreviewEntity reviewer;
  const ListingReviewEntity({
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
    required this.reviewer,
    required this.photos,
  });

  @override
  List<Object?> get props => [
        identity,
        reviewer,
        star,
        summary,
        content,
        experiencedAt,
        reviewedAt,
        photos,
        likes,
        dislikes,
        liked,
        disliked,
      ];
}

class UserReviewEntity extends ReviewCoreEntity {
  final List<String> photos;
  final BusinessPreviewEntity listing;
  const UserReviewEntity({
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
    required this.photos,
    required this.listing,
  });

  @override
  List<Object?> get props => [
        identity,
        listing,
        star,
        summary,
        content,
        experiencedAt,
        reviewedAt,
        photos,
        likes,
        dislikes,
        liked,
        disliked,
      ];
}
