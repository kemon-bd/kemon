import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../business.dart';

part 'category_event.dart';
part 'category_state.dart';

class FindBusinessesByCategoryBloc extends Bloc<FindBusinessesByCategoryEvent, FindBusinessesByCategoryState> {
  final BusinessesByCategoryUseCase useCase;
  FindBusinessesByCategoryBloc({required this.useCase}) : super(const FindBusinessesByCategoryInitial()) {
    on<FindBusinessesByCategory>((event, emit) async {
      emit(const FindBusinessesByCategoryLoading());
      final result = await useCase(category: event.category, page: 1);
      result.fold(
        (failure) => emit(FindBusinessesByCategoryError(failure: failure)),
        (response) => emit(
          FindBusinessesByCategoryDone(
            page: 1,
            total: response.total,
            businesses: response.businesses,
            related: response.related,
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
        ));
        final result = await useCase(category: event.category, page: event.page);
        result.fold(
          (failure) => emit(FindBusinessesByCategoryError(failure: failure)),
          (response) => emit(
            FindBusinessesByCategoryDone(
              page: event.page,
              total: response.total,
              businesses: response.businesses,
              related: response.related,
            ),
          ),
        );
      }
    });
  }
}
