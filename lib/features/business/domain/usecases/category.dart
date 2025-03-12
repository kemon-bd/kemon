import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessesByCategoryUseCase {
  final BusinessRepository repository;

  BusinessesByCategoryUseCase({
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
      await repository.category(
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
