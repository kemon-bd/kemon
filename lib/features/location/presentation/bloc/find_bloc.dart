import '../../../../core/shared/shared.dart';
import '../../location.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindLocationBloc extends Bloc<FindLocationEvent, FindLocationState> {
  final FindLocationUseCase find;
  final RefreshLocationUseCase refresh;
  FindLocationBloc({
    required this.find,
    required this.refresh,
  }) : super(const FindLocationInitial()) {
    on<FindLocation>((event, emit) async {
      emit(const FindLocationLoading());
      final result = await find(urlSlug: event.urlSlug);
      result.fold(
        (failure) => emit(FindLocationError(failure: failure)),
        (location) => emit(FindLocationDone(location: location)),
      );
    });
    on<RefreshLocation>((event, emit) async {
      emit(const FindLocationLoading());
      final result = await refresh(urlSlug: event.urlSlug);
      result.fold(
        (failure) => emit(FindLocationError(failure: failure)),
        (location) => emit(FindLocationDone(location: location)),
      );
    });
  }
}
