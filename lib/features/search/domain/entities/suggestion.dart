import '../../../../core/shared/shared.dart';

class SearchSuggestionEntity extends Equatable {
  final Name name;
  final String urlSlug;
  final String? logo;

  const SearchSuggestionEntity({
    required this.name,
    required this.urlSlug,
    required this.logo,
  });

  @override
  List<Object?> get props => [name, urlSlug, logo];
}
