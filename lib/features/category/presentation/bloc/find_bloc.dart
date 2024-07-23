import '../../../../core/shared/shared.dart';
import '../../category.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindCategoryBloc extends Bloc<FindCategoryEvent, FindCategoryState> {
  final FindCategoryUseCase useCase;
  FindCategoryBloc({required this.useCase}) : super(const FindCategoryInitial()) {
    on<FindCategory>((event, emit) async {
      emit(const FindCategoryLoading());
      final result = await useCase(urlSlug: event.urlSlug);
      result.fold(
        (failure) => emit(FindCategoryError(failure: failure)),
        (category) => emit(FindCategoryDone(category: category)),
      );
    });
  }
}
