import '../../../category/category.dart';

class IndustryEntity extends CategoryEntity {
  const IndustryEntity({
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
