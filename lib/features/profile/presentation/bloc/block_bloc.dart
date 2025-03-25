import '../../../../core/shared/shared.dart' show Failure, Bloc, Equatable, Identity;
import '../../profile.dart' show BlockSomeoneUseCase;

part 'block_event.dart';
part 'block_state.dart';

class BlockBloc extends Bloc<BlockEvent, BlockState> {
  final BlockSomeoneUseCase useCase;
  BlockBloc({
    required this.useCase,
  }) : super(BlockInitial()) {
    on<BlockAbuser>((event, emit) async {
      emit(BlockLoading());
      final result = await useCase(victim: event.abuser, reason: event.reason);

      result.fold(
        (failure) => emit(BlockError(failure: failure)),
        (_) => emit(BlockDone()),
      );
    });
  }
}
