import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindLeaderboardBloc
    extends Bloc<FindLeaderboardEvent, FindLeaderboardState> {
  final FindLeaderboardUseCase useCase;
  FindLeaderboardBloc({required this.useCase})
      : super(const FindLeaderboardInitial()) {
    on<FindLeaderboard>((event, emit) async {
      emit(const FindLeaderboardLoading());
      final result = await useCase(guid: event.leaderboard);
      result.fold(
        (failure) => emit(FindLeaderboardError(failure: failure)),
        (leaderboard) => emit(FindLeaderboardDone(leaderboard: leaderboard)),
      );
    });
  }
}
