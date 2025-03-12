import '../../../../core/shared/shared.dart';
import '../../business.dart';

class RefreshBusinessesByCategoryUseCase {
  final BusinessRepository repository;

  RefreshBusinessesByCategoryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<BusinessLiteEntity>>> call({
    required Identity industry,
    required Identity? category,
    required Identity? subCategory,
    required String? division,
    required String? district,
    required String? thana,
    required String? query,
    required SortBy? sort,
    required RatingRange ratings,
  }) async =>
      await repository.refreshCategory(
        industry: industry,
        category: category,
        subCategory: subCategory,
        division: division,
        district: district,
        thana: thana,
        query: query,
        sort: sort,
        ratings: ratings,
      );
}
