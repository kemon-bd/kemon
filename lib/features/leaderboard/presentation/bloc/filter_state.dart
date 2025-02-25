part of 'filter_bloc.dart';

sealed class LeaderboardFilterState extends Equatable {
  final DateRangeOption option;
  final DateTimeRange range;
  const LeaderboardFilterState({
    required this.option,
    required this.range,
  });

  @override
  List<Object> get props => [
        option,
        range,
      ];
}

final class DefaultLeaderboardFilter extends LeaderboardFilterState {
  DefaultLeaderboardFilter()
      : super(
          option: DateRangeOption.allTime,
          range: DateRangeOption.allTime.evaluate,
        );
}

final class CustomLeaderboardFilter extends LeaderboardFilterState {
  const CustomLeaderboardFilter({
    required super.option,
    required super.range,
  });

  factory CustomLeaderboardFilter.parse({
    required Map<String, dynamic> map,
  }) {
    return CustomLeaderboardFilter(
      option: DateRangeOption.values.elementAt(map['option']),
      range: DateTimeRange(
        start: DateTime.parse(map['start']),
        end: DateTime.parse(map['end']),
      ),
    );
  }

  @override
  List<Object> get props => [
        option,
        range,
      ];
}
