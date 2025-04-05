import '../../../../core/shared/shared.dart';
import '../../category.dart';

part 'industry_event.dart';
part 'industry_state.dart';

class FindCategoriesByIndustryBloc extends Bloc<FindCategoriesByIndustryEvent, FindCategoriesByIndustryState> {
  final FindCategoriesByIndustryUseCase useCase;
  FindCategoriesByIndustryBloc({
    required this.useCase,
  }) : super(FindCategoriesByIndustryInitial()) {
    on<FindCategoriesByIndustry>((event, emit) async {
      emit(FindCategoriesByIndustryLoading());

      final result = await useCase(industry: event.industry);

      result.fold(
        (failure) => emit(FindCategoriesByIndustryError(failure: failure)),
        (categories) => emit(FindCategoriesByIndustryDone(categories: categories)),
      );
    });
  }
}
