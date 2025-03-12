import 'package:kemon/core/shared/shared.dart';

import '../../../features/leaderboard/leaderboard.dart';

extension LeaderboardEntityExtension on List<LeaderEntity> {
  List<RankedLeaderEntity> get ranked {
    sort((a, b) => b.point.compareTo(a.point));
    return mapIndexed((index, e) => RankedLeaderEntity(
          rank: index,
          identity: e.identity,
          name: e.name,
          avatar: e.avatar,
          point: e.point,
        )).toList();
  }
}

extension LeaderboardModelExtension on LeaderModel {}
