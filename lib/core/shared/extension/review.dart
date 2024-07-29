import '../../../features/review/review.dart';

extension ReviewEntityExtension on ReviewEntity {}

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
