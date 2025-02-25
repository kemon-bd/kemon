part of 'filter_bloc.dart';

sealed class LeaderboardFilterEvent extends Equatable {
  const LeaderboardFilterEvent();

  @override
  List<Object> get props => [];
}

class SwitchLeaderboardFilter extends LeaderboardFilterEvent {
  final DateRangeOption option;
  final DateTimeRange range;
  const SwitchLeaderboardFilter({
    required this.option,
    required this.range,
  });
}

class ResetLeaderboardFilter extends LeaderboardFilterEvent {
  const ResetLeaderboardFilter();
}
