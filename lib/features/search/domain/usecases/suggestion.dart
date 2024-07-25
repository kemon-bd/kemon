import '../../../../core/shared/shared.dart';
import '../../search.dart';

class SearchSuggestionsUseCase {
  final SearchRepository repository;

  SearchSuggestionsUseCase({
    required this.repository,
  });

  Future<Either<Failure, AutoCompleteSuggestions>> call({
    required String query,
  }) async {
    return await repository.suggestion(query: query);
  }
}
