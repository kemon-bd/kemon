import '../../../../core/shared/shared.dart';

class ReviewEntity extends Equatable {
  final Identity identity;
  final Identity user;
  final String listing;
  final int rating;
  final String title;
  final String? description;
  final DateTime experiencedAt;
  final DateTime reviewedAt;
  final bool deleted;
  final bool flagged;
  final List<String> photos;

  const ReviewEntity({
    required this.identity,
    required this.user,
    required this.listing,
    required this.rating,
    required this.title,
    required this.description,
    required this.experiencedAt,
    required this.reviewedAt,
    required this.photos,
    required this.deleted,
    required this.flagged,
  });

  @override
  List<Object?> get props => [
        identity,
        user,
        listing,
        rating,
        title,
        description,
        experiencedAt,
        reviewedAt,
        photos,
      ];
}
