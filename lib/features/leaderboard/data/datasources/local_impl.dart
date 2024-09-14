import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class LeaderboardLocalDataSourceImpl extends LeaderboardLocalDataSource {
  final Map<String, LeaderboardEntity> _cache = {};

  @override
  FutureOr<void> add({
    required LeaderboardEntity leaderboard,
  }) {
    _cache[leaderboard.guid] = leaderboard;
  }

  @override
  FutureOr<void> addAll({
    required List<LeaderboardEntity> items,
  }) {
    for (final item in items) {
      _cache[item.guid] = item;
    }
  }

  @override
  FutureOr<void> update({
    required LeaderboardEntity leaderboard,
  }) {
    _cache[leaderboard.guid] = leaderboard;
  }

  @override
  FutureOr<void> remove({
    required String guid,
  }) {
    _cache.remove(guid);
  }

  @override
  FutureOr<void> removeAll() {
    _cache.clear();
  }

  @override
  FutureOr<LeaderboardEntity> find({
    required String guid,
  }) {
    final item = _cache[guid];
    if (item == null) {
      throw LeaderboardNotFoundInLocalCacheFailure();
    }
    return item;
  }
}
