import '../../../category/category.dart';
import '../../../search/search.dart';

class IndustryEntity extends CategoryEntity {
  const IndustryEntity({
    required super.identity,
    required super.name,
    required super.icon,
    required super.urlSlug,
  }) : super(industry: identity);

  @override
  List<Object> get props => [
        industry,
        name,
        icon,
        urlSlug,
      ];
}

class IndustryWithListingCountEntity extends IndustryEntity {
  final int listings;
  final List<CategoryWithListingCountEntity> categories;

  const IndustryWithListingCountEntity({
    required super.identity,
    required super.name,
    required super.icon,
    required super.urlSlug,
    required this.listings,
    required this.categories,
  });

  @override
  List<Object> get props => [
        ...super.props,
        listings,
        categories,
      ];
}

class IndustrySuggestionEntity extends IndustryEntity implements SearchSuggestionEntity {
  const IndustrySuggestionEntity({
    required super.identity,
    required super.name,
    required super.icon,
    required super.urlSlug,
  });

  @override
  String? get logo => super.icon;
}
