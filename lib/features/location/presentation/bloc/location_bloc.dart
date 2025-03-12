import '../../../../core/shared/shared.dart';
import '../../location.dart';

part 'location_event.dart';
part 'location_state.dart';

class FindLocationsByCategoryBloc extends Bloc<FindLocationsByCategoryEvent, FindLocationsByCategoryState> {
  final FindLocationsByCategoriesUseCase useCase;
  FindLocationsByCategoryBloc({
    required this.useCase,
  }) : super(FindLocationsByCategoryInitial()) {
    on<FindLocationsByCategory>((event, emit) async {
      emit(FindLocationsByCategoryLoading());

      final result = await useCase(
        query: null,
        industry: event.industry,
        category: event.category,
        subCategory: event.subCategory,
      );
      result.fold(
        (failure) => emit(FindLocationsByCategoryError(failure: failure)),
        (industries) => emit(FindLocationsByCategoryDone(divisions: industries)),
      );
    });
    on<SearchLocationsByCategory>((event, emit) async {
      emit(FindLocationsByCategoryLoading());

      final result = await useCase(
        query: event.query,
        industry: event.industry,
        category: event.category,
        subCategory: event.subCategory,
      );
      result.fold(
        (failure) => emit(FindLocationsByCategoryError(failure: failure)),
        (industries) => emit(FindLocationsByCategoryDone(divisions: industries)),
      );
    });
  }
}
