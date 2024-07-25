import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../category/category.dart';
import '../../../industry/industry.dart';
import '../../../location/location.dart';
import '../../../sub_category/sub_category.dart';

typedef AutoCompleteSuggestions = ({
  List<BusinessEntity> businesses,
  List<IndustryEntity> industries,
  List<CategoryEntity> categories,
  List<SubCategoryEntity> subCategories,
});

typedef SearchResults = ({
  List<BusinessEntity> businesses,
  List<SubCategoryEntity> subCategories,
  List<LocationEntity> locations,
});

typedef FilterOptions = ({
  String? sortBy,
  String? filterBy,
  String? division,
  String? district,
  String? thana,
  String? industry,
  String? category,
  String? subCategory,
});

abstract class SearchRepository {
  Future<Either<Failure, AutoCompleteSuggestions>> suggestion({
    required String query,
  });

  Future<Either<Failure, SearchResults>> result({
    required String query,
    required FilterOptions filter,
  });
}
