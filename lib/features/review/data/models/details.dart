import '../../review.dart';

class ReviewDetailsModel extends ReviewDetailsEntity {
  const ReviewDetailsModel({
    required super.rating,
    required super.reviews,
  });

  factory ReviewDetailsModel.parse({
    required Map<String, dynamic> map,
  }) {
    return ReviewDetailsModel(
      rating: RatingModel.parse(map: map['ratings']),
      reviews: (map['reviews'] as List)
          .map(
            (e) => ReviewModel.parse(map: e),
          )
          .toList(),
    );
  }
}
