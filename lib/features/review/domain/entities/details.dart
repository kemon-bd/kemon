
import '../../../../core/shared/shared.dart';
import '../../review.dart';

class ReviewDetailsEntity extends Equatable {
  final RatingEntity rating;
  final List<ReviewEntity> reviews;

  const ReviewDetailsEntity({
    required this.rating,
    required this.reviews,
  });

  @override
  List<Object?> get props => [
        rating,
        reviews,
      ];
}
