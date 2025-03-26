import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../industry/industry.dart';
import '../../../lookup/lookup.dart';
import '../../../review/review.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

typedef ListingModel = (BusinessModel, BusinessRatingInsightsModel, List<ListingReviewModel>);

abstract class BusinessRemoteDataSource {
  FutureOr<ListingModel> find({
    required String urlSlug,
    required Identity? user,
  });

  FutureOr<List<BusinessLiteModel>> category({
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

  FutureOr<List<BusinessLiteModel>> location({
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

  FutureOr<void> validateUrlSlug({
    required String urlSlug,
  });

  FutureOr<void> publish({
    required String token,
    required Identity user,
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
