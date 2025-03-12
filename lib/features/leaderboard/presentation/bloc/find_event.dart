part of 'find_bloc.dart';

abstract class FindLeaderboardEvent extends Equatable {
  const FindLeaderboardEvent();

  @override
  List<Object> get props => [];
}

class FindLeaderboard extends FindLeaderboardEvent {
  final String query;

  const FindLeaderboard({
    required this.query,
  });

  @override
  List<Object> get props => [query];
}

class RefreshLeaderboard extends FindLeaderboardEvent {
  final String query;

  const RefreshLeaderboard({
    required this.query,
  });
  @override
  List<Object> get props => [query];
}