import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../search/search.dart';

class SubCategoryEntity extends CategoryEntity {
  final Identity category;
  const SubCategoryEntity({
    required this.category,
    required super.identity,
    required super.industry,
    required super.name,
    required super.icon,
    required super.urlSlug,
  });

  @override
  List<Object> get props => [
        ...super.props,
        category,
      ];
}

class SubCategoryWithListingCountEntity extends SubCategoryEntity {
  final int listings;

  const SubCategoryWithListingCountEntity({
    required super.identity,
    required super.category,
    required super.industry,
    required super.name,
    required super.icon,
    required super.urlSlug,
    required this.listings,
  });

  @override
  List<Object> get props => [
        ...super.props,
        listings,
      ];
}

class SubCategorySuggestionEntity extends SubCategoryEntity implements SearchSuggestionEntity {
  const SubCategorySuggestionEntity({
    required super.category,
    required super.identity,
    required super.industry,
    required super.name,
    required super.icon,
    required super.urlSlug,
  });

  @override
  String? get logo => super.icon;
}
