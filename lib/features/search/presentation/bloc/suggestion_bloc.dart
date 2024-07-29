import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../industry/industry.dart';
import '../../../sub_category/sub_category.dart';
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
        (suggestions) => emit(
          SearchSuggestionDone(
            businesses: suggestions.businesses,
            industries: suggestions.industries,
            categories: suggestions.categories,
            subCategories: suggestions.subCategories,
            suggestions: suggestions,
          ),
        ),
      );
    });
    on<ResetSuggestion>((event, emit) async {
      emit(const SearchSuggestionInitial());
    });
  }
}
