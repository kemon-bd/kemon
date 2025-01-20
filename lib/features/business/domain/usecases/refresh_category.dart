import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

class RefreshBusinessesByCategoryUseCase {
  final BusinessRepository repository;

  RefreshBusinessesByCategoryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, BusinessesByCategoryPaginatedResponse>> call({
    required String urlSlug,
    required String? query,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required CategoryEntity? category,
    required SubCategoryEntity? subCategory,
    required List<int> ratings,
  }) async =>
      await repository.refreshCategory(
        urlSlug: urlSlug,
        query: query,
        sort: sort,
        division: division,
        district: district,
        thana: thana,
        category: category,
        sub: subCategory,
        ratings: ratings,
      );
}
