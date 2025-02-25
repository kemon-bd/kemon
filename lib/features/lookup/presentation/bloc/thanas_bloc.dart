import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

part 'thanas_event.dart';
part 'thanas_state.dart';

class ThanasBloc extends Bloc<ThanasEvent, ThanasState> {
  final FindLookupUseCase useCase;
  ThanasBloc({
    required this.useCase,
  }) : super(const ThanasInitial()) {
    on<FindThanas>((event, emit) async {
      emit(const ThanasLoading());
      final result = await useCase(
        key: (key: Lookups.thana, parent: event.district),
      );
      result.fold(
        (failure) => emit(ThanasError(failure: failure)),
        (lookups) => emit(ThanasDone(thanas: lookups)),
      );
    });
  }
}
