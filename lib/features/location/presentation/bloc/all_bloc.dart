import '../../../../core/shared/shared.dart';
import '../../location.dart';

part 'all_event.dart';
part 'all_state.dart';

class FindAllLocationsBloc extends Bloc<FindAllLocationsEvent, FindAllLocationsState> {
  final FindAllLocationsUseCase useCase;
  FindAllLocationsBloc({
    required this.useCase,
  }) : super(FindAllLocationsInitial()) {
    on<FindAllLocations>((event, emit) async {
      emit(FindAllLocationsLoading());
      final result = await useCase(query: null);
      result.fold(
        (failure) => emit(FindAllLocationsError(failure: failure)),
        (divisions) => emit(FindAllLocationsDone(divisions: divisions)),
      );
    });
    on<SearchAllLocations>((event, emit) async {
      emit(FindAllLocationsLoading());
      final result = await useCase(query: event.query);
      result.fold(
        (failure) => emit(FindAllLocationsError(failure: failure)),
        (divisions) => emit(FindAllLocationsDone(divisions: divisions)),
      );
    });
  }
}
