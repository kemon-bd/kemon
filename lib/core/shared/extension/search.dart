import 'package:kemon/core/shared/shared.dart';

import '../../../features/search/search.dart';

extension SearchSuggestionEntities on List<SearchSuggestionEntity> {
  List<SearchSuggestionEntity> arrange({
    required String query,
  }) {
    final startsWith = where((s) => s.name.full.begin(by: query)).toList();
    final contains = where((s) => !s.name.full.begin(by: query) && s.name.full.match(like: query)).toList();
    final endsWith =
        where((s) => !s.name.full.begin(by: query) && !s.name.full.match(like: query) && s.name.full.end(by: query)).toList();
    startsWith.sort((a, b) => a.name.full.compareTo(b.name.full));
    contains.sort((a, b) => a.name.full.compareTo(b.name.full));
    endsWith.sort((a, b) => a.name.full.compareTo(b.name.full));
    clear();
    addAll(startsWith);
    addAll(contains);
    addAll(endsWith);
    return this;
  }
}
