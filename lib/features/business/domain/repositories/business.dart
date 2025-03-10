import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../industry/industry.dart';
import '../../../location/location.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

typedef BusinessesByCategoryPaginatedResponse = ({
  int total,
  List<BusinessEntity> businesses,
  List<SubCategoryEntity> related,
});
typedef BusinessesByLocationPaginatedResponse = ({
  int total,
  List<BusinessEntity> businesses,
  List<LocationEntity> related,
});

abstract class BusinessRepository {
  FutureOr<Either<Failure, BusinessEntity>> find({
    required String urlSlug,
  });

  FutureOr<Either<Failure, BusinessEntity>> refresh({
    required String urlSlug,
  });

  FutureOr<Either<Failure, BusinessesByCategoryPaginatedResponse>> category({
    required int page,
    required String urlSlug,
    required String? query,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required CategoryEntity? category,
    required SubCategoryEntity? sub,
    required List<int> ratings,
  });
  FutureOr<Either<Failure, BusinessesByCategoryPaginatedResponse>> refreshCategory({
    required String urlSlug,
    required String? query,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required CategoryEntity? category,
    required SubCategoryEntity? sub,
    required List<int> ratings,
  });

  FutureOr<Either<Failure, BusinessesByLocationPaginatedResponse>> location({
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
  });
  FutureOr<Either<Failure, BusinessesByLocationPaginatedResponse>> refreshLocation({
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
  });

  FutureOr<Either<Failure, void>> validateUrlSlug({
    required String urlSlug,
  });

  FutureOr<Either<Failure, void>> publish({
    required String name,
    required String urlSlug,
    required String about,
    required XFile? logo,
    required ListingType type,
    required String phone,
    required String email,
    required String website,
    required String social,
    required IndustryEntity industry,
    required CategoryEntity? category,
    required SubCategoryEntity? subCategory,
    required String address,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
  });
}
