import '../../../category/category.dart';

class SubCategoryEntity extends CategoryEntity {
  const SubCategoryEntity({
    required super.identity,
    required super.name,
    required super.icon,
    required super.urlSlug,
  });

  @override
  List<Object> get props => [
        identity,
        name,
        icon,
        urlSlug,
      ];
}
