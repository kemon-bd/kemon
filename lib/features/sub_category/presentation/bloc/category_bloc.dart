import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

part 'category_event.dart';
part 'category_state.dart';

class SubCategoriesByCategoryBloc extends Bloc<SubCategoriesByCategoryEvent, SubCategoriesByCategoryState> {
  final SubCategoriesByCategoryUseCase useCase;
  SubCategoriesByCategoryBloc({
    required this.useCase,
  }) : super(const SubCategoriesByCategoryInitial()) {
    on<SubCategoriesByCategory>((event, emit) async {
      emit(const SubCategoriesByCategoryLoading());
      final result = await useCase(category: event.category);
      result.fold(
        (failure) => emit(SubCategoriesByCategoryError(failure: failure)),
        (subCategories) => emit(SubCategoriesByCategoryDone(subCategories: subCategories)),
      );
    });
  }
}
