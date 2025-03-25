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

  FutureOr<List<UserReviewModel>> find({
    required Identity user,
  });

  FutureOr<void> update({
    required String token,
    required Identity user,
    required Identity listing,
    required ReviewCoreEntity review,
    required List<XFile> attachments,
  });

  FutureOr<void> react({
    required String token,
    required Identity review,
    required Identity listing,
    required Identity user,
    required Reaction reaction,
  });
  FutureOr<void> flag({
    required String token,
    required Identity review,
    required Identity user,
    required String? reason,
  });
}
