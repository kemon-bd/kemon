import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../location/location.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

part 'category_event.dart';
part 'category_state.dart';

class FindBusinessesByCategoryBloc extends Bloc<FindBusinessesByCategoryEvent, FindBusinessesByCategoryState> {
  final BusinessesByCategoryUseCase find;
  FindBusinessesByCategoryBloc({required this.find}) : super(const FindBusinessesByCategoryInitial()) {
    on<FindBusinessesByCategory>((event, emit) async {
      emit(FindBusinessesByCategoryLoading(
        sortBy: event.sort,
        ratings: event.ratings,
        division: event.division,
        district: event.district,
        thana: event.thana,
        subCategory: event.subCategory,
      ));
      final result = await find(
        category: event.category,
        page: 1,
        sort: event.sort,
        division: event.division,
        district: event.district,
        thana: event.thana,
        subCategory: event.subCategory,
        ratings: event.ratings,
      );
      result.fold(
        (failure) => emit(FindBusinessesByCategoryError(
          failure: failure,
          sortBy: event.sort,
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
            sortBy: event.sort,
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
          sortBy: event.sort,
          ratings: event.ratings,
          division: event.division,
          district: event.district,
          thana: event.thana,
          subCategory: event.subCategory,
        ));
        final result = await find(
          category: event.category,
          page: event.page,
          sort: event.sort,
          division: event.division,
          district: event.district,
          thana: event.thana,
          subCategory: event.subCategory,
          ratings: event.ratings,
        );
        result.fold(
          (failure) => emit(FindBusinessesByCategoryError(
            failure: failure,
            sortBy: event.sort,
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
              sortBy: event.sort,
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
