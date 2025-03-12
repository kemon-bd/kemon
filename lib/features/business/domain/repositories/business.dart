import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../industry/industry.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

abstract class BusinessRepository {
  FutureOr<Either<Failure, ListingEntity>> find({
    required String urlSlug,
  });

  FutureOr<Either<Failure, ListingEntity>> refresh({
    required String urlSlug,
  });

  FutureOr<Either<Failure, List<BusinessLiteEntity>>> category({
    required Identity industry,
    required Identity? category,
    required Identity? subCategory,
    required String? division,
    required String? district,
    required String? thana,
    required String? query,
    required SortBy? sort,
    required RatingRange ratings,
  });
  FutureOr<Either<Failure, List<BusinessLiteEntity>>> refreshCategory({
    required Identity industry,
    required Identity? category,
    required Identity? subCategory,
    required String? division,
    required String? district,
    required String? thana,
    required String? query,
    required SortBy? sort,
    required RatingRange ratings,
  });

  FutureOr<Either<Failure, List<BusinessLiteEntity>>> location({
    required String division,
    String? district,
    String? thana,
    required String? query,
    required Identity? industry,
    required Identity? category,
    required Identity? subCategory,
    required SortBy? sort,
    required RatingRange ratings,
  });

  FutureOr<Either<Failure, List<BusinessLiteEntity>>> refreshLocation({
    required String division,
    String? district,
    String? thana,
    required String? query,
    required Identity? industry,
    required Identity? category,
    required Identity? subCategory,
    required SortBy? sort,
    required RatingRange ratings,
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
