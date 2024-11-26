part of 'find_bloc.dart';

abstract class FindLeaderboardState extends Equatable {
  final String query;
  final DateTime from;
  final DateTime to;

  const FindLeaderboardState({
    this.query = '',
    required this.to,
    required this.from,
  });

  @override
  List<Object> get props => [];
}

class FindLeaderboardInitial extends FindLeaderboardState {
  FindLeaderboardInitial()
      : super(
          from: DateTime.now().startOfThisYear,
          to: DateTime.now().endOfThisYear,
        );
}

class FindLeaderboardLoading extends FindLeaderboardState {
  const FindLeaderboardLoading({
    required super.query,
    required super.from,
    required super.to,
  });
}

class FindLeaderboardError extends FindLeaderboardState {
  final Failure failure;

  const FindLeaderboardError({
    required this.failure,
    required super.query,
    required super.from,
    required super.to,
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
    required super.from,
    required super.to,
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
    required super.from,
    required super.to,
  });

  @override
  List<Object> get props => [leaders, page, total, deadline];
}
