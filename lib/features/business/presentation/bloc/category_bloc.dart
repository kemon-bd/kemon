import '../../../../core/shared/shared.dart';
import '../../business.dart';

part 'category_event.dart';
part 'category_state.dart';

class FindBusinessesByCategoryBloc extends Bloc<FindBusinessesByCategoryEvent, FindBusinessesByCategoryState> {
  final BusinessesByCategoryUseCase useCase;
  FindBusinessesByCategoryBloc({required this.useCase}) : super(const FindBusinessesByCategoryInitial()) {
    on<FindBusinessesByCategory>((event, emit) async {
      emit(const FindBusinessesByCategoryLoading());
      final result = await useCase(category: event.category);
      result.fold(
        (failure) => emit(FindBusinessesByCategoryError(failure: failure)),
        (businesses) => emit(FindBusinessesByCategoryDone(businesses: businesses)),
      );
    });
  }
}
