part of 'find_bloc.dart';

abstract class FindLeaderboardState extends Equatable {
  final String query;

  const FindLeaderboardState({
    this.query = '',
  });

  @override
  List<Object> get props => [];
}

class FindLeaderboardInitial extends FindLeaderboardState {
  const FindLeaderboardInitial();
}

class FindLeaderboardLoading extends FindLeaderboardState {
  const FindLeaderboardLoading({
    required super.query,
  });
}

class FindLeaderboardError extends FindLeaderboardState {
  final Failure failure;

  const FindLeaderboardError({
    required this.failure,
    required super.query,
  });

  @override
  List<Object> get props => [failure];
}

class FindLeaderboardDone extends FindLeaderboardState {
  final int page;
  final int total;
  final DateTime deadline;
  final List<LeaderEntity> leaders;

  const FindLeaderboardDone({
    required this.page,
    required this.total,
    required this.deadline,
    required this.leaders,
    required super.query,
  });

  @override
  List<Object> get props => [leaders, page, total, deadline];
}

class FindLeaderboardPaginating extends FindLeaderboardDone {
  const FindLeaderboardPaginating({
    required super.page,
    required super.total,
    required super.deadline,
    required super.leaders,
    required super.query,
  });

  @override
  List<Object> get props => [leaders, page, total, deadline];
}
