import '../../../../core/shared/shared.dart';
import '../../review.dart';

abstract class ReviewRemoteDataSource {
  FutureOr<void> create({
    required String token,
    required Identity user,
    required Identity listing,
    required double rating,
    required String title,
    required String description,
    required String date,
    required List<XFile> attachments,
  });

  FutureOr<void> delete({
    required String token,
    required Identity user,
    required Identity review,
  });

  Future<RatingModel> rating({
    required String token,
    required String urlSlug,
  });

  FutureOr<List<ReviewModel>> find({
    required Identity user,
  });

  FutureOr<void> update({
    required String token,
    required Identity user,
    required ReviewEntity review,
  });
}
