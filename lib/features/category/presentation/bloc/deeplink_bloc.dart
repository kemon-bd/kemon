import '../../../../core/shared/shared.dart';
import '../../category.dart';

part 'deeplink_event.dart';
part 'deeplink_state.dart';

class CategoryDeeplinkBloc extends Bloc<CategoryDeeplinkEvent, CategoryDeeplinkState> {
  final FindCategoryDeeplinkUseCase useCase;

  CategoryDeeplinkBloc({
    required this.useCase,
  }) : super(CategoryDeeplinkInitial()) {
    on<CategoryDeeplink>((event, emit) async {
      emit(CategoryDeeplinkLoading());
      final result = await useCase(urlSlug: event.urlSlug);
      result.fold(
        (failure) => emit(CategoryDeeplinkError(failure: failure)),
        (category) => emit(CategoryDeeplinkDone(category: category)),
      );
    });
  }
}
