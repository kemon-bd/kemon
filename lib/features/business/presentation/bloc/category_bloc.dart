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
        category: event.category,
      ));
      final result = await find(
        urlSlug: event.urlSlug,
        page: 1,
        query: event.query ?? '',
        sort: event.sort ?? SortBy.recommended,
        division: event.division,
        district: event.district,
        thana: event.thana,
        category: event.category,
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
          category: event.category,
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
            category: event.category,
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
        category: event.category,
      ));
      final result = await refresh(
        urlSlug: event.urlSlug,
        query: event.query ?? '',
        sort: event.sort ?? SortBy.recommended,
        division: event.division,
        district: event.district,
        thana: event.thana,
        subCategory: event.subCategory,
        ratings: event.ratings,
        category: event.category,
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
          category: event.category,
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
            category: event.category,
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
          category: event.category,
          subCategory: event.subCategory,
        ));
        final result = await find(
          urlSlug: event.urlSlug,
          page: event.page,
          query: event.query ?? '',
          sort: event.sort ?? SortBy.recommended,
          division: event.division,
          district: event.district,
          thana: event.thana,
          subCategory: event.subCategory,
          ratings: event.ratings,
          category: event.category,
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
            category: event.category,
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
              category: event.category,
              subCategory: event.subCategory,
            ),
          ),
        );
      }
    });
  }
}
