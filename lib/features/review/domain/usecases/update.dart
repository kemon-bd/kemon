import '../../../../core/shared/shared.dart';
import '../../review.dart';

class UpdateReviewUseCase {
  final ReviewRepository repository;

  UpdateReviewUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required Identity listing,
    required ReviewCoreEntity review,
    required List<XFile> attachments
  }) async {
    return await repository.update(
      review: review,
      listing: listing,
      attachments: attachments,
    );
  }
}
