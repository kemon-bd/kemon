import '../../../../core/shared/shared.dart';
import '../../business.dart';


part 'category_event.dart';
part 'category_state.dart';

class BusinessesByCategoryBloc extends Bloc<BusinessesByCategoryEvent, BusinessesByCategoryState> {
  final BusinessesByCategoryUseCase useCase;
  BusinessesByCategoryBloc({required this.useCase}) : super(const BusinessesByCategoryInitial()) {
    on<BusinessesByCategory>((event, emit) async {
      emit(const BusinessesByCategoryLoading());
      final result = await useCase(category: event.category);
      result.fold(
        (failure) => emit(BusinessesByCategoryError(failure: failure)),
        (businesses) => emit(BusinessesByCategoryDone(businesses: businesses)),
      );
    });
  }
}
