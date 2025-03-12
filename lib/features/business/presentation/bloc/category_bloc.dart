import '../../../../core/shared/shared.dart';
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
      emit(FindBusinessesByCategoryLoading());
      final result = await find(
        query: null,
        industry: event.industry,
        category: event.category,
        subCategory: event.subCategory,
        division: event.division,
        district: event.district,
        thana: event.thana,
        sort: event.sort ?? SortBy.recommended,
        ratings: event.ratings,
      );
      result.fold(
        (failure) => emit(FindBusinessesByCategoryError(failure: failure)),
        (businesses) => emit(FindBusinessesByCategoryDone(businesses: businesses)),
      );
    });
    on<SearchBusinessesByCategory>((event, emit) async {
      emit(FindBusinessesByCategoryLoading());
      final result = await find(
        query: event.query,
        industry: event.industry,
        category: event.category,
        subCategory: event.subCategory,
        division: event.division,
        district: event.district,
        thana: event.thana,
        sort: event.sort ?? SortBy.recommended,
        ratings: event.ratings,
      );
      result.fold(
        (failure) => emit(FindBusinessesByCategoryError(failure: failure)),
        (businesses) => emit(FindBusinessesByCategoryDone(businesses: businesses)),
      );
    });

    on<RefreshBusinessesByCategory>((event, emit) async {
      emit(FindBusinessesByCategoryLoading());
      final result = await refresh(
        query: '',
        industry: event.industry,
        category: event.category,
        subCategory: event.subCategory,
        division: event.division,
        district: event.district,
        thana: event.thana,
        sort: event.sort ?? SortBy.recommended,
        ratings: event.ratings,
      );
      result.fold(
        (failure) => emit(FindBusinessesByCategoryError(failure: failure)),
        (businesses) => emit(FindBusinessesByCategoryDone(businesses: businesses)),
      );
    });
  }
}
