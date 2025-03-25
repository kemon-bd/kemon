import '../../../../core/shared/shared.dart' show Failure, Bloc, Equatable;
import '../../profile.dart' show BlockListUseCase, UserPreviewEntity;

part 'block_list_event.dart';
part 'block_list_state.dart';

class BlockListBloc extends Bloc<BlockListEvent, BlockListState> {
  final BlockListUseCase useCase;
  BlockListBloc({
    required this.useCase,
  }) : super(BlockListInitial()) {
    on<FindBlockList>((event, emit) async {
      emit(BlockListLoading());
      final result = await useCase();

      result.fold(
        (failure) => emit(BlockListError(failure: failure)),
        (users) => emit(BlockListDone(users: users)),
      );
    });
  }
}
