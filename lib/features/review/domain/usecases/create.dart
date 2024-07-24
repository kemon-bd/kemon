import '../../../../core/shared/shared.dart';
import '../../review.dart';

class CreateReviewUseCase {
  final ReviewRepository repository;

  CreateReviewUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, void>> call({
    required Identity listing,
    required double rating,
    required String title,
    required String description,
    required String date,
    required List<XFile> attachments,
  }) async {
    return await repository.create(
      listing: listing,
      rating: rating,
      title: title,
      description: description,
      date: date,
      attachments: attachments,
    );
  }
}
