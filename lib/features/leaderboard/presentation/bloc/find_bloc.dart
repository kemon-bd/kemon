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
        from: event.from,
        to: event.to,
        query: event.query,
      ));
      final result = await find(
        page: 1,
        query: event.query,
        from: event.from,
        to: event.to,
      );
      result.fold(
        (failure) => emit(FindLeaderboardError(
          failure: failure,
          from: event.from,
          to: event.to,
          query: event.query,
        )),
        (leaderboard) => emit(FindLeaderboardDone(
          leaders: leaderboard.leaders,
          total: leaderboard.total,
          page: 1,
          deadline: leaderboard.deadline,
          from: event.from,
          to: event.to,
          query: event.query,
        )),
      );
    });

    on<RefreshLeaderboard>((event, emit) async {
      emit(FindLeaderboardLoading(
        from: event.from,
        to: event.to,
        query: event.query,
      ));
      final result = await refresh(
        from: event.from,
        to: event.to,
      );
      result.fold(
        (failure) => emit(FindLeaderboardError(
          failure: failure,
          from: event.from,
          to: event.to,
          query: event.query,
        )),
        (leaderboard) => emit(FindLeaderboardDone(
          leaders: leaderboard.leaders,
          total: leaderboard.total,
          page: 1,
          deadline: leaderboard.deadline,
          from: event.from,
          to: event.to,
          query: event.query,
        )),
      );
    });

    on<PaginateLeaderboard>((event, emit) async {
      final oldState = (state as FindLeaderboardDone);
      emit(FindLeaderboardPaginating(
        from: event.from,
        to: event.to,
        query: event.query,
        page: event.page,
        deadline: oldState.deadline,
        leaders: oldState.leaders,
        total: oldState.total,
      ));
      final result = await find(
        page: event.page,
        query: event.query,
        from: event.from,
        to: event.to,
      );
      result.fold(
        (failure) => emit(FindLeaderboardError(
          failure: failure,
          from: event.from,
          to: event.to,
          query: event.query,
        )),
        (leaderboard) => emit(FindLeaderboardDone(
          leaders: leaderboard.leaders,
          total: leaderboard.total,
          page: event.page,
          deadline: leaderboard.deadline,
          from: event.from,
          to: event.to,
          query: event.query,
        )),
      );
    });
  }
}
