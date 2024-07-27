import '../../../../core/shared/shared.dart';
import '../../search.dart';

part 'result_event.dart';
part 'result_state.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  final SearchResultUseCase useCase;
  SearchResultBloc({
    required this.useCase,
  }) : super(const SearchResultInitial()) {
    on<SearchResult>((event, emit) async {
      emit(const SearchResultLoading());

      final result = await useCase(
        query: event.query,
        filter: event.filter,
      );

      result.fold(
        (failure) => emit(SearchResultError(failure: failure)),
        (results) => emit(SearchResultDone(results: results)),
      );
    });
  }
}