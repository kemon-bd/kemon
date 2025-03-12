import '../../../../core/shared/shared.dart';
import '../../search.dart';

class SearchSuggestionModel extends SearchSuggestionEntity {
  const SearchSuggestionModel({
    required super.name,
    required super.urlSlug,
    required super.logo,
  });

  factory SearchSuggestionModel.parse({
    required Map<String, dynamic> map,
  }) {
    return SearchSuggestionModel(
      name: Name.full(name: map['name'] as String),
      urlSlug: map['urlSlug'] as String,
      logo: map['logo'] as String?,
    );
  }
}
