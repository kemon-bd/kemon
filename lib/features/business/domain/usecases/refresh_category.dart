import '../../../../core/shared/shared.dart';
import '../../../location/location.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

class RefreshBusinessesByCategoryUseCase {
  final BusinessRepository repository;

  RefreshBusinessesByCategoryUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, BusinessesByCategoryPaginatedResponse>> call({
    required int page,
    required String category,
    required SortBy? sort,
    required LocationEntity? division,
    required LocationEntity? district,
    required LocationEntity? thana,
    required SubCategoryEntity? subCategory,
    required List<int> ratings,
  }) async =>
      await repository.category(
        category: category,
        page: page,
        sort: sort,
        division: division,
        district: district,
        thana: thana,
        sub: subCategory,
        ratings: ratings,
      );
}
