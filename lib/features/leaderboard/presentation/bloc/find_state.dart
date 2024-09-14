part of 'find_bloc.dart';

abstract class FindLeaderboardState extends Equatable {
  const FindLeaderboardState();

  @override
  List<Object> get props => [];
}

class FindLeaderboardInitial extends FindLeaderboardState {
  const FindLeaderboardInitial();
}

class FindLeaderboardLoading extends FindLeaderboardState {
  const FindLeaderboardLoading();
}

class FindLeaderboardError extends FindLeaderboardState {
  final Failure failure;

  const FindLeaderboardError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindLeaderboardDone extends FindLeaderboardState {
  final LeaderboardEntity leaderboard;

  const FindLeaderboardDone({required this.leaderboard});

  @override
  List<Object> get props => [leaderboard];
}
