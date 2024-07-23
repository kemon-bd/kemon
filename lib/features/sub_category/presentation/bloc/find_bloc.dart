import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindSubCategoryBloc extends Bloc<FindSubCategoryEvent, FindSubCategoryState> {
  final FindSubCategoryUseCase useCase;
  FindSubCategoryBloc({
    required this.useCase,
  }) : super(const FindSubCategoryInitial()) {
    on<FindSubCategory>((event, emit) async {
      emit(const FindSubCategoryLoading());
      final result = await useCase(urlSlug: event.urlSlug);
      result.fold(
        (failure) => emit(FindSubCategoryError(failure: failure)),
        (subCategory) => emit(FindSubCategoryDone(subCategory: subCategory)),
      );
    });
  }
}
