part of 'find_bloc.dart';

abstract class FindLeaderboardEvent extends Equatable {
  const FindLeaderboardEvent();

  @override
  List<Object> get props => [];
}

class FindLeaderboard extends FindLeaderboardEvent {
  final String query;
  final DateTime from;
  final DateTime to;

  const FindLeaderboard({
    required this.query,
    required this.from,
    required this.to,
  });
  @override
  List<Object> get props => [query, from, to];
}

class RefreshLeaderboard extends FindLeaderboardEvent {
  final String query;
  final DateTime from;
  final DateTime to;

  const RefreshLeaderboard({
    required this.query,
    required this.from,
    required this.to,
  });
  @override
  List<Object> get props => [query, from, to];
}

class PaginateLeaderboard extends FindLeaderboardEvent {
  final int page;
  final String query;
  final DateTime from;
  final DateTime to;

  const PaginateLeaderboard({
    required this.page,
    required this.query,
    required this.from,
    required this.to,
  });
  @override
  List<Object> get props => [page, query, from, to];
}
