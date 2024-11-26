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
  }) {
    final key = (
      page: page,
      query: query,
      from: from,
      to: to,
    );
    final item = _cache[key];
    if (item == null) {
      throw LeaderboardNotFoundInLocalCacheFailure();
    }
    return item;
  }
}
