import '../../../../core/shared/shared.dart' show Failure, Bloc, Equatable, Identity;
import '../../profile.dart' show UnblockSomeoneUseCase;
part 'unblock_event.dart';
part 'unblock_state.dart';

class UnblockBloc extends Bloc<UnblockEvent, UnblockState> {
  final UnblockSomeoneUseCase useCase;
  UnblockBloc({
    required this.useCase,
  }) : super(UnblockInitial()) {
    on<UnblockAbuser>((event, emit) async {
      emit(UnblockLoading());
      final result = await useCase(victim: event.abuser);

      result.fold(
        (failure) => emit(UnblockError(failure: failure)),
        (_) => emit(UnblockDone()),
      );
    });
  }
}
