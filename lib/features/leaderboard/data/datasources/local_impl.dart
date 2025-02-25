import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

typedef LeaderboardKey = ({
  int page,
  String query,
  DateTime from,
  DateTime to,
});

class LeaderboardLocalDataSourceImpl extends LeaderboardLocalDataSource {
  final Map<LeaderboardKey, LeaderboardResponse> _cache = {};

  @override
  FutureOr<void> add({
    required int page,
    required String query,
    required DateTime from,
    required DateTime to,
    required LeaderboardResponse leaderboard,
  }) {
    final key = (
      page: page,
      query: query,
      from: from,
      to: to,
    );
    _cache[key] = leaderboard;
  }

  @override
  FutureOr<void> removeAll() {
    _cache.clear();
  }

  @override
  FutureOr<LeaderboardResponse> find({
    required int page,
    required String query,
    required DateTime from,
    required DateTime to,
  }) async {
    int total = 0;
    DateTime deadline = DateTime.now();
    List<LeaderEntity> results = [];

    for (int p = 1; p <= page; p++) {
      final tempKey = (
        page: p,
        query: query,
        from: from,
        to: to,
      );

      if (!_cache.containsKey(tempKey)) {
        throw LeaderboardNotFoundInLocalCacheFailure();
      }

      final item = _cache[tempKey]; // Use tempKey here
      if (item != null) {
        deadline = item.deadline;
        total = item.total;
        results.addAll(item.leaders);
      }
    }

    return (
      deadline: deadline,
      leaders: results,
      total: total,
    );
  }
}
