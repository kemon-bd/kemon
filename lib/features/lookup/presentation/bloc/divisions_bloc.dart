import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

part 'divisions_event.dart';
part 'divisions_state.dart';

class DivisionsBloc extends Bloc<DivisionsEvent, DivisionsState> {
  final FindLookupUseCase useCase;
  DivisionsBloc({
    required this.useCase,
  }) : super(const DivisionsInitial()) {
    on<FindDivisions>((event, emit) async {
      emit(const DivisionsLoading());
      final result = await useCase(
        key: (key: Lookups.division, parent: null),
      );
      result.fold(
        (failure) => emit(DivisionsError(failure: failure)),
        (lookups) => emit(DivisionsDone(divisions: lookups)),
      );
    });
  }
}
