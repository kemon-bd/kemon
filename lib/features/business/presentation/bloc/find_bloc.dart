import '../../../../core/shared/shared.dart';
import '../../business.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindBusinessBloc extends Bloc<FindBusinessEvent, FindBusinessState> {
  final FindBusinessUseCase useCase;
  FindBusinessBloc({required this.useCase})
      : super(const FindBusinessInitial()) {
    on<FindBusiness>((event, emit) async {
      emit(const FindBusinessLoading());
      final result = await useCase(urlSlug: event.urlSlug);
      result.fold(
        (failure) => emit(FindBusinessError(failure: failure)),
        (business) => emit(FindBusinessDone(business: business)),
      );
    });
  }
}
