import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindLeaderboardBloc extends Bloc<FindLeaderboardEvent, FindLeaderboardState> {
  final FindLeaderboardUseCase find;
  final RefreshLeaderboardUseCase refresh;
  FindLeaderboardBloc({
    required this.find,
    required this.refresh,
  }) : super(FindLeaderboardInitial()) {
    on<FindLeaderboard>((event, emit) async {
      emit(FindLeaderboardLoading());
      final result = await find(
        query: event.query,
      );
      result.fold(
        (failure) => emit(FindLeaderboardError(failure: failure)),
        (leaderboard) => emit(FindLeaderboardDone(leaders: leaderboard)),
      );
    });

    on<RefreshLeaderboard>((event, emit) async {
      emit(FindLeaderboardLoading());
      final result = await refresh();
      result.fold(
        (failure) => emit(FindLeaderboardError(failure: failure)),
        (leaderboard) => emit(FindLeaderboardDone(leaders: leaderboard)),
      );
    });
  }
}
