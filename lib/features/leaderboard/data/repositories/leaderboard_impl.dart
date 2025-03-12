import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class LeaderboardRepositoryImpl extends LeaderboardRepository {
  final NetworkInfo network;
  final LeaderboardFilterBloc filter;
  final LeaderboardLocalDataSource local;
  final LeaderboardRemoteDataSource remote;

  LeaderboardRepositoryImpl({
    required this.network,
    required this.filter,
    required this.local,
    required this.remote,
  });

  @override
  FutureOr<Either<Failure, List<RankedLeaderEntity>>> find({
    required String query,
  }) async {
    try {
      final rankedLeaders = await local.find(
        from: filter.state.range.start,
        to: filter.state.range.end,
      );
      return Right(query.isEmpty ? rankedLeaders : rankedLeaders.where((l) => l.name.full.match(like: query)).toList());
    } on LeaderboardNotFoundInLocalCacheFailure catch (_) {
      if (await network.online) {
        final result = await remote.find(
          from: filter.state.range.start,
          to: filter.state.range.end,
        );
        final rankedLeaders = result.ranked;
        await local.add(
          from: filter.state.range.start,
          to: filter.state.range.end,
          leaders: rankedLeaders,
        );
        return Right(query.isEmpty ? rankedLeaders : rankedLeaders.where((l) => l.name.full.match(like: query)).toList());
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, List<RankedLeaderEntity>>> refresh() async {
    try {
      if (await network.online) {
        await local.removeAll();

        final result = await remote.find(
          from: filter.state.range.start,
          to: filter.state.range.end,
        );

        final rankedLeaders = result.ranked;
        await local.add(
          from: filter.state.range.start,
          to: filter.state.range.end,
          leaders: rankedLeaders,
        );
        return Right(rankedLeaders);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
