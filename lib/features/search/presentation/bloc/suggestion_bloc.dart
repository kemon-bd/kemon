import '../../../../core/shared/shared.dart';
import '../../search.dart';

part 'suggestion_event.dart';
part 'suggestion_state.dart';

class SearchSuggestionBloc extends Bloc<SearchSuggestionEvent, SearchSuggestionState> {
  final SearchSuggestionsUseCase useCase;
  SearchSuggestionBloc({
    required this.useCase,
  }) : super(const SearchSuggestionInitial()) {
    on<SearchSuggestion>((event, emit) async {
      emit(const SearchSuggestionLoading());

      final result = await useCase(query: event.query);
      result.fold(
        (failure) => emit(SearchSuggestionError(failure: failure)),
        (suggestions) => emit(SearchSuggestionDone(suggestions: suggestions)),
      );
    });
    on<ResetSuggestion>((event, emit) async {
      emit(const SearchSuggestionInitial());
    });
  }
}
