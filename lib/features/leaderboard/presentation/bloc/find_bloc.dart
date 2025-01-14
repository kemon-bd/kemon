import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindLeaderboardBloc
    extends Bloc<FindLeaderboardEvent, FindLeaderboardState> {
  final FindLeaderboardUseCase find;
  final RefreshLeaderboardUseCase refresh;
  FindLeaderboardBloc({
    required this.find,
    required this.refresh,
  }) : super(FindLeaderboardInitial()) {
    on<FindLeaderboard>((event, emit) async {
      emit(FindLeaderboardLoading(
        query: event.query,
      ));
      final result = await find(
        page: 1,
        query: event.query,
      );
      result.fold(
        (failure) => emit(FindLeaderboardError(
          failure: failure,
          query: event.query,
        )),
        (leaderboard) => emit(FindLeaderboardDone(
          leaders: leaderboard.leaders,
          total: leaderboard.total,
          page: 1,
          deadline: leaderboard.deadline,
          query: event.query,
        )),
      );
    });

    on<RefreshLeaderboard>((event, emit) async {
      emit(FindLeaderboardLoading(
        query: event.query,
      ));
      final result = await refresh(
      );
      result.fold(
        (failure) => emit(FindLeaderboardError(
          failure: failure,
          query: event.query,
        )),
        (leaderboard) => emit(FindLeaderboardDone(
          leaders: leaderboard.leaders,
          total: leaderboard.total,
          page: 1,
          deadline: leaderboard.deadline,
          query: event.query,
        )),
      );
    });

    on<PaginateLeaderboard>((event, emit) async {
      final oldState = (state as FindLeaderboardDone);
      emit(FindLeaderboardPaginating(
        query: event.query,
        page: event.page,
        deadline: oldState.deadline,
        leaders: oldState.leaders,
        total: oldState.total,
      ));
      final result = await find(
        page: event.page,
        query: event.query,
      );
      result.fold(
        (failure) => emit(FindLeaderboardError(
          failure: failure,
          query: event.query,
        )),
        (leaderboard) => emit(FindLeaderboardDone(
          leaders: leaderboard.leaders,
          total: leaderboard.total,
          page: event.page,
          deadline: leaderboard.deadline,
          query: event.query,
        )),
      );
    });
  }
}
