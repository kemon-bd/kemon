import '../../../../core/shared/shared.dart';
import '../../category.dart';

part 'industry_event.dart';
part 'industry_state.dart';

class CategoriesByIndustryBloc
    extends Bloc<CategoriesByIndustryEvent, CategoriesByIndustryState> {
  final CategoriesByIndustryUseCase useCase;
  CategoriesByIndustryBloc({required this.useCase})
      : super(const CategoriesByIndustryInitial()) {
    on<CategoriesByIndustry>((event, emit) async {
      emit(const CategoriesByIndustryLoading());
      final result = await useCase(industry: event.industry);
      result.fold(
        (failure) => emit(CategoriesByIndustryError(failure: failure)),
        (categories) => emit(CategoriesByIndustryDone(categories: categories)),
      );
    });
  }
}
