import '../../../../core/shared/shared.dart';
import '../../review.dart';

class UpdateReviewUseCase {
  final ReviewRepository repository;

  UpdateReviewUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required ReviewCoreEntity review,
    required List<String> photos,
    required List<XFile> attachments,
  }) async {
    return await repository.update(
      review: review,
      photos: photos,
      attachments: attachments,
    );
  }
}
