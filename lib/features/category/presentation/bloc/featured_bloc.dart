import '../../../../core/shared/shared.dart';
import '../../category.dart';

part 'featured_event.dart';
part 'featured_state.dart';

class FeaturedCategoriesBloc
    extends Bloc<FeaturedCategoriesEvent, FeaturedCategoriesState> {
  final FeaturedCategoriesUseCase useCase;
  FeaturedCategoriesBloc({required this.useCase})
      : super(const FeaturedCategoriesInitial()) {
    on<FeaturedCategories>((event, emit) async {
      emit(const FeaturedCategoriesLoading());
      final result = await useCase();
      result.fold(
        (failure) => emit(FeaturedCategoriesError(failure: failure)),
        (categories) => emit(FeaturedCategoriesDone(categories: categories)),
      );
    });
  }
}
