import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../industry/industry.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

class BusinessesByLocationUseCase {
  final BusinessRepository repository;

  BusinessesByLocationUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, BusinessesByLocationPaginatedResponse>> call({
    required int page,
    required String location,
    required String? division,
    required String? district,
    required String? thana,
    required String? query,
    required SortBy? sort,
    required IndustryEntity? industry,
    required CategoryEntity? category,
    required SubCategoryEntity? sub,
    required List<int> ratings,
  }) async =>
      await repository.location(
        page: page,
        location: location,
        division: division,
        district: district,
        thana: thana,
        query: query,
        sort: sort,
        ratings: ratings,
        industry: industry,
        category: category,
        sub: sub,
      );
}
