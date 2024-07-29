import '../../../category/category.dart';

class SubCategoryEntity extends CategoryEntity {
  const SubCategoryEntity({
    required super.name,
    required super.icon,
    required super.urlSlug,
  });

  @override
  List<Object> get props => [
        name,
        icon,
        urlSlug,
      ];
}
