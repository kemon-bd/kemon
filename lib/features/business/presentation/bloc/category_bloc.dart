import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

part 'category_event.dart';
part 'category_state.dart';

class FindBusinessesByCategoryBloc extends Bloc<FindBusinessesByCategoryEvent, FindBusinessesByCategoryState> {
  final BusinessesByCategoryUseCase find;
  final RefreshBusinessesByCategoryUseCase refresh;
  FindBusinessesByCategoryBloc({
    required this.find,
    required this.refresh,
  }) : super(const FindBusinessesByCategoryInitial()) {
    on<FindBusinessesByCategory>((event, emit) async {
      emit(FindBusinessesByCategoryLoading(
        query: event.query ?? '',
        sortBy: event.sort ?? SortBy.recommended,
        ratings: event.ratings,
        division: event.division,
        district: event.district,
        thana: event.thana,
        subCategory: event.subCategory,
      ));
      final result = await find(
        category: event.category,
        page: 1,
        query: event.query ?? '',
        sort: event.sort ?? SortBy.recommended,
        division: event.division,
        district: event.district,
        thana: event.thana,
        subCategory: event.subCategory,
        ratings: event.ratings,
      );
      result.fold(
        (failure) => emit(FindBusinessesByCategoryError(
          failure: failure,
          query: event.query ?? '',
          sortBy: event.sort ?? SortBy.recommended,
          ratings: event.ratings,
          division: event.division,
          district: event.district,
          thana: event.thana,
          subCategory: event.subCategory,
        )),
        (response) => emit(
          FindBusinessesByCategoryDone(
            page: 1,
            total: response.total,
            businesses: response.businesses,
            related: response.related,
            query: event.query ?? '',
            sortBy: event.sort ?? SortBy.recommended,
            ratings: event.ratings,
            division: event.division,
            district: event.district,
            thana: event.thana,
            subCategory: event.subCategory,
          ),
        ),
      );
    });
    on<RefreshBusinessesByCategory>((event, emit) async {
      emit(FindBusinessesByCategoryLoading(
        query: event.query ?? '',
        sortBy: event.sort ?? SortBy.recommended,
        ratings: event.ratings,
        division: event.division,
        district: event.district,
        thana: event.thana,
        subCategory: event.subCategory,
      ));
      final result = await refresh(
        category: event.category,
        query: event.query ?? '',
        sort: event.sort ?? SortBy.recommended,
        division: event.division,
        district: event.district,
        thana: event.thana,
        subCategory: event.subCategory,
        ratings: event.ratings,
      );
      result.fold(
        (failure) => emit(FindBusinessesByCategoryError(
          failure: failure,
          query: event.query ?? '',
          sortBy: event.sort ?? SortBy.recommended,
          ratings: event.ratings,
          division: event.division,
          district: event.district,
          thana: event.thana,
          subCategory: event.subCategory,
        )),
        (response) => emit(
          FindBusinessesByCategoryDone(
            page: 1,
            total: response.total,
            businesses: response.businesses,
            related: response.related,
            query: event.query ?? '',
            sortBy: event.sort ?? SortBy.recommended,
            ratings: event.ratings,
            division: event.division,
            district: event.district,
            thana: event.thana,
            subCategory: event.subCategory,
          ),
        ),
      );
    });

    on<PaginateBusinessesByCategory>((event, emit) async {
      if (state is! FindBusinessesByCategoryPaginating) {
        final oldState = (state as FindBusinessesByCategoryDone);
        emit(FindBusinessesByCategoryPaginating(
          total: oldState.total,
          page: event.page,
          businesses: oldState.businesses,
          related: oldState.related,
          query: event.query ?? '',
          sortBy: event.sort ?? SortBy.recommended,
          ratings: event.ratings,
          division: event.division,
          district: event.district,
          thana: event.thana,
          subCategory: event.subCategory,
        ));
        final result = await find(
          category: event.category,
          page: event.page,
          query: event.query ?? '',
          sort: event.sort ?? SortBy.recommended,
          division: event.division,
          district: event.district,
          thana: event.thana,
          subCategory: event.subCategory,
          ratings: event.ratings,
        );
        result.fold(
          (failure) => emit(FindBusinessesByCategoryError(
            failure: failure,
            query: event.query ?? '',
            sortBy: event.sort ?? SortBy.recommended,
            ratings: event.ratings,
            division: event.division,
            district: event.district,
            thana: event.thana,
            subCategory: event.subCategory,
          )),
          (response) => emit(
            FindBusinessesByCategoryDone(
              page: event.page,
              total: response.total,
              businesses: response.businesses,
              related: response.related,
              query: event.query ?? '',
              sortBy: event.sort ?? SortBy.recommended,
              ratings: event.ratings,
              division: event.division,
              district: event.district,
              thana: event.thana,
              subCategory: event.subCategory,
            ),
          ),
        );
      }
    });
  }
}
