import '../../../../core/shared/shared.dart';
import '../../../search/search.dart';
import '../../../sub_category/sub_category.dart';

class CategoryEntity extends Equatable {
  final Identity industry;
  final Identity identity;
  final Name name;
  final String icon;
  final String urlSlug;

  const CategoryEntity({
    required this.industry,
    required this.identity,
    required this.name,
    required this.icon,
    required this.urlSlug,
  });

  @override
  List<Object> get props => [
        industry,
        identity,
        name,
        icon,
        urlSlug,
      ];
}

class CategoryWithListingCountEntity extends CategoryEntity {
  final int listings;
  final List<SubCategoryWithListingCountEntity> subCategories;

  const CategoryWithListingCountEntity({
    required super.industry,
    required super.identity,
    required super.name,
    required super.icon,
    required super.urlSlug,
    required this.listings,
    required this.subCategories,
  });

  @override
  List<Object> get props => [
        ...super.props,
        listings,
        subCategories,
      ];
}

class CategorySuggestionEntity extends CategoryEntity implements SearchSuggestionEntity {
  const CategorySuggestionEntity({
    required super.identity,
    required super.industry,
    required super.name,
    required super.icon,
    required super.urlSlug,
  });

  @override
  String? get logo => super.icon;
}
