import '../../../../core/shared/shared.dart';
import '../../category.dart';

part 'find_all_event.dart';
part 'find_all_state.dart';

class FindAllCategoriesBloc
    extends Bloc<FindAllCategoriesEvent, FindAllCategoriesState> {
  final FindAllCategoryUseCase find;
  final FindAllCategoryUseCase refresh;

  FindAllCategoriesBloc({
    required this.find,
    required this.refresh,
  }) : super(FindAllCategoriesInitial()) {
    on<FindAllCategories>((event, emit) async {
      emit(FindAllCategoriesLoading(
          industry: event.industry, query: event.query));
      final result =
          await find(page: 1, industry: event.industry, query: event.query);
      result.fold(
        (failure) => emit(FindAllCategoriesError(
            failure: failure, industry: event.industry, query: event.query)),
        (response) => emit(FindAllCategoriesDone(
          page: 1,
          results: response.results,
          total: response.total,
          industry: event.industry,
          query: event.query,
        )),
      );
    });

    on<PaginateAllCategories>((event, emit) async {
      if (state is! FindAllCategoriesPaginating) {
        final oldState = (state as FindAllCategoriesDone);
        emit(FindAllCategoriesPaginating(
          page: oldState.page,
          results: oldState.results,
          total: oldState.total,
          industry: oldState.industry,
          query: oldState.query,
        ));
        final result = await find(
            page: event.page, industry: event.industry, query: event.query);
        result.fold(
          (failure) => emit(FindAllCategoriesError(
              failure: failure, industry: event.industry, query: event.query)),
          (response) => emit(FindAllCategoriesDone(
            page: event.page,
            results: response.results,
            total: response.total,
            industry: event.industry,
            query: event.query,
          )),
        );
      }
    });

    on<RefreshAllCategories>((event, emit) async {
      emit(FindAllCategoriesLoading(
          industry: event.industry, query: event.query));
      final result =
          await refresh(page: 1, industry: event.industry, query: event.query);
      result.fold(
        (failure) => emit(FindAllCategoriesError(
            failure: failure, industry: event.industry, query: event.query)),
        (response) => emit(FindAllCategoriesDone(
          page: 1,
          results: response.results,
          total: response.total,
          industry: event.industry,
          query: event.query,
        )),
      );
    });
  }
}
