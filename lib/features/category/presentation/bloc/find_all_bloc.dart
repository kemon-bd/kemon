import '../../../../core/shared/shared.dart';
import '../../../industry/industry.dart';
import '../../category.dart';

part 'find_all_event.dart';
part 'find_all_state.dart';

class FindAllCategoriesBloc extends Bloc<FindAllCategoriesEvent, FindAllCategoriesState> {
  final FindAllCategoryUseCase find;
  final RefreshAllCategoryUseCase refresh;

  FindAllCategoriesBloc({
    required this.find,
    required this.refresh,
  }) : super(FindAllCategoriesInitial()) {
    on<FindAllCategories>((event, emit) async {
      emit(FindAllCategoriesLoading());
      final result = await find(query: event.query);
      result.fold(
        (failure) => emit(FindAllCategoriesError(failure: failure)),
        (industries) => emit(FindAllCategoriesDone(industries: industries)),
      );
    });

    on<RefreshAllCategories>((event, emit) async {
      emit(FindAllCategoriesLoading());
      final result = await refresh();
      result.fold(
        (failure) => emit(FindAllCategoriesError(failure: failure)),
        (industries) => emit(FindAllCategoriesDone(industries: industries)),
      );
    });
  }
}
