import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../location/location.dart';
import '../../../sub_category/sub_category.dart';
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
        (results) => emit(SearchResultDone(
          businesses: results.businesses,
          subCategories: results.subCategories,
          locations: results.locations,
        )),
      );
    });
  }
}
