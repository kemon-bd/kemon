import '../../../../core/shared/shared.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class LeaderboardFilterBloc extends HydratedBloc<LeaderboardFilterEvent, LeaderboardFilterState> {
  LeaderboardFilterBloc() : super(DefaultLeaderboardFilter()) {
    on<SwitchLeaderboardFilter>((event, emit) {
      emit(
        CustomLeaderboardFilter(
          option: event.option,
          range: event.range,
        ),
      );
    });
    on<ResetLeaderboardFilter>((event, emit) {
      emit(DefaultLeaderboardFilter());
    });
  }

  @override
  LeaderboardFilterState? fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return DefaultLeaderboardFilter();
    } else {
      return CustomLeaderboardFilter.parse(map: json);
    }
  }

  @override
  Map<String, dynamic>? toJson(LeaderboardFilterState state) {
    return {
      'option': state.option.index,
      'start': state.range.start.toIso8601String(),
      'end': state.range.end.toIso8601String(),
    };
  }
}
