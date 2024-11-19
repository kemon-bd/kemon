import '../../../category/category.dart';

class IndustryEntity extends CategoryEntity {
  const IndustryEntity({
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
