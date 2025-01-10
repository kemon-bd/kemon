import '../shared.dart';

class SearchKeys {
  final SearchSuggestionKeys suggestion = SearchSuggestionKeys();
}

class SearchSuggestionKeys {
  final Key field = Key('search#suggestion#field');
  final Key submit = Key('search#suggestion#submit');
}
