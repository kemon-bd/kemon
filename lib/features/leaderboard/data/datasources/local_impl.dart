import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class LeaderboardLocalDataSourceImpl extends LeaderboardLocalDataSource {
  final Map<DateTimeRange, List<RankedLeaderEntity>> _cache = {};

  @override
  FutureOr<void> add({
    required DateTime from,
    required DateTime to,
    required List<RankedLeaderEntity> leaders,
  }) {
    _cache[DateTimeRange(start: from, end: to)] = leaders;
  }

  @override
  FutureOr<void> removeAll() {
    _cache.clear();
  }

  @override
  FutureOr<List<RankedLeaderEntity>> find({
    required DateTime from,
    required DateTime to,
  }) async {
    final item = _cache[DateTimeRange(start: from, end: to)];

    if (item == null) {
      throw LeaderboardNotFoundInLocalCacheFailure();
    }

    return item;
  }
}
