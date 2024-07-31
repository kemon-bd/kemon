import '../../../../core/shared/shared.dart';
import '../../business.dart';

part 'category_event.dart';
part 'category_state.dart';

class FindBusinessesByCategoryBloc extends Bloc<FindBusinessesByCategoryEvent, FindBusinessesByCategoryState> {
  final BusinessesByCategoryUseCase useCase;
  FindBusinessesByCategoryBloc({required this.useCase}) : super(const FindBusinessesByCategoryInitial()) {
    on<FindBusinessesByCategory>((event, emit) async {
      emit(FindBusinessesByCategoryLoading(type: state.type));
      final result = await useCase(category: event.category);
      result.fold(
        (failure) => emit(FindBusinessesByCategoryError(failure: failure, type: state.type)),
        (businesses) => emit(FindBusinessesByCategoryDone(businesses: businesses, type: state.type)),
      );
    });

    on<ToggleListingType>((event, emit) {
      final newState = state.copyWith(type: event.type);
      emit(newState);
    });
  }
}
