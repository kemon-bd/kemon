import '../../../../core/shared/shared.dart';

class CategoryEntity extends Equatable {
  final Name name;
  final String icon;
  final String urlSlug;

  const CategoryEntity({
    required this.name,
    required this.icon,
    required this.urlSlug,
  });

  @override
  List<Object> get props => [
        name,
        icon,
        urlSlug,
      ];
}
