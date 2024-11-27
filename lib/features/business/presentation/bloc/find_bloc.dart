import '../../../../core/shared/shared.dart';
import '../../business.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindBusinessBloc extends Bloc<FindBusinessEvent, FindBusinessState> {
  final FindBusinessUseCase find;
  final RefreshBusinessUseCase refresh;
  FindBusinessBloc({
    required this.find,
    required this.refresh,
  }) : super(const FindBusinessInitial()) {
    on<FindBusiness>((event, emit) async {
      emit(const FindBusinessLoading());
      final result = await find(urlSlug: event.urlSlug);
      result.fold(
        (failure) => emit(FindBusinessError(failure: failure)),
        (business) => emit(FindBusinessDone(business: business)),
      );
    });
    on<RefreshBusiness>((event, emit) async {
      emit(const FindBusinessLoading());
      final result = await refresh(urlSlug: event.urlSlug);
      result.fold(
        (failure) => emit(FindBusinessError(failure: failure)),
        (business) => emit(FindBusinessDone(business: business)),
      );
    });
  }
}
