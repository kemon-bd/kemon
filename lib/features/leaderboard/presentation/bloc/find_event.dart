part of 'find_bloc.dart';

abstract class FindLeaderboardEvent extends Equatable {
  const FindLeaderboardEvent();

  @override
  List<Object> get props => [];
}

class FindLeaderboard extends FindLeaderboardEvent {
  final String leaderboard;

  const FindLeaderboard({
    required this.leaderboard,
  });
  @override
  List<Object> get props => [leaderboard];
}
