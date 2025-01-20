import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

part 'category_event.dart';
part 'category_state.dart';

class SubCategoriesByCategoryBloc extends Bloc<SubCategoriesByCategoryEvent, SubCategoriesByCategoryState> {
  final SubCategoriesByCategoryUseCase find;
  final SearchSubCategoriesByCategoryUseCase search;
  SubCategoriesByCategoryBloc({
    required this.find,
    required this.search,
  }) : super(const SubCategoriesByCategoryInitial()) {
    on<SubCategoriesByCategory>((event, emit) async {
      emit(const SubCategoriesByCategoryLoading());
      final result = await find(category: event.category);
      result.fold(
        (failure) => emit(SubCategoriesByCategoryError(failure: failure)),
        (subCategories) => emit(SubCategoriesByCategoryDone(subCategories: subCategories)),
      );
    });
    on<SearchSubCategoriesByCategory>((event, emit) async {
      emit(const SubCategoriesByCategoryLoading());
      final result = await search(category: event.category, query: event.query);
      result.fold(
        (failure) => emit(SubCategoriesByCategoryError(failure: failure)),
        (subCategories) => emit(SubCategoriesByCategoryDone(subCategories: subCategories)),
      );
    });
  }
}
