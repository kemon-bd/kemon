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
  FutureOr<Either<Failure, LeaderboardResponse>> find({
    required int page,
    required String query,
  }) async {
    try {
      final result = await local.find(
        page: page,
        query: query,
        from: filter.state.range.start,
        to: filter.state.range.end,
      );
      return Right(result);
    } on LeaderboardNotFoundInLocalCacheFailure catch (_) {
      if (await network.online) {
        final result = await remote.find(
          page: page,
          query: query,
          from: filter.state.range.start,
          to: filter.state.range.end,
        );
        await local.add(
          page: page,
          query: query,
          from: filter.state.range.start,
          to: filter.state.range.end,
          leaderboard: result,
        );
        final total = page == 1
            ? result
            : await local.find(
                page: page,
                query: query,
                from: filter.state.range.start,
                to: filter.state.range.end,
              );
        return Right(total);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, LeaderboardResponse>> refresh() async {
    try {
      if (await network.online) {
        await local.removeAll();

        final result = await remote.find(
          page: 1,
          query: '',
          from: filter.state.range.start,
          to: filter.state.range.end,
        );

        await local.add(
          page: 1,
          query: '',
          from: filter.state.range.start,
          to: filter.state.range.end,
          leaderboard: result,
        );

        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
