import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessesByCategoryUseCase {
  final BusinessRepository repository;

  BusinessesByCategoryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, BusinessesByCategoryPaginatedResponse>> call({
    required int page,
    required String category,
  }) async =>
      await repository.category(category: category, page: page);
}
