import '../../../../core/shared/shared.dart';
import '../../search.dart';

class SearchSuggestionsUseCase {
  final SearchRepository repository;

  SearchSuggestionsUseCase({
    required this.repository,
  });

  Future<Either<Failure, List<SearchSuggestionEntity>>> call({
    required String query,
  }) async {
    return await repository.suggestion(query: query);
  }
}
