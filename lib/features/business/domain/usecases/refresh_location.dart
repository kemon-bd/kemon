import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../industry/industry.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

class RefreshBusinessesByLocationUseCase {
  final BusinessRepository repository;

  RefreshBusinessesByLocationUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, BusinessesByLocationPaginatedResponse>> call({
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
      await repository.refreshLocation(
        location: location,
        division: division,
        district: district,
        thana: thana,
        query: query,
        industry: industry,
        category: category,
        sub: sub,
        sort: sort,
        ratings: ratings,
      );
}
