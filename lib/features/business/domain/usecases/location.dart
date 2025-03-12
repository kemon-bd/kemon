import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessesByLocationUseCase {
  final BusinessRepository repository;

  BusinessesByLocationUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, List<BusinessLiteEntity>>> call({
    required String division,
    String? district,
    String? thana,
    required String? query,
    required Identity? industry,
    required Identity? category,
    required Identity? subCategory,
    required SortBy? sort,
    required RatingRange ratings,
  }) async =>
      await repository.location(
        division: division,
        district: district,
        thana: thana,
        query: query,
        industry: industry,
        category: category,
        subCategory: subCategory,
        sort: sort,
        ratings: ratings,
      );
}
