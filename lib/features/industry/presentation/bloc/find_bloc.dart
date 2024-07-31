import '../../../../core/shared/shared.dart';
import '../../industry.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindIndustryBloc extends Bloc<FindIndustryEvent, FindIndustryState> {
  final FindIndustryUseCase useCase;
  FindIndustryBloc({required this.useCase})
      : super(const FindIndustryInitial()) {
    on<FindIndustry>((event, emit) async {
      emit(const FindIndustryLoading());
      final result = await useCase(urlSlug: event.urlSlug);
      result.fold(
        (failure) => emit(FindIndustryError(failure: failure)),
        (industries) => emit(FindIndustryDone(industry: industries)),
      );
    });
  }
}
