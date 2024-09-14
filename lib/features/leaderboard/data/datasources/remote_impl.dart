import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class LeaderboardRemoteDataSourceImpl extends LeaderboardRemoteDataSource {
  final Client client;

  LeaderboardRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<void> create({
    required LeaderboardEntity leaderboard,
  }) async {
    throw UnimplementedError();
  }

  @override
  FutureOr<void> delete({
    required String guid,
  }) async {
    throw UnimplementedError();
  }

  @override
  FutureOr<LeaderboardModel> find({
    required String guid,
  }) async {
    throw UnimplementedError();
  }

  @override
  FutureOr<List<LeaderboardModel>> read() async {
    throw UnimplementedError();
  }

  @override
  FutureOr<List<LeaderboardModel>> refresh() async {
    throw UnimplementedError();
  }

  @override
  FutureOr<List<LeaderboardModel>> search({
    required String query,
  }) async {
    throw UnimplementedError();
  }

  @override
  FutureOr<void> update({
    required LeaderboardEntity leaderboard,
  }) async {
    throw UnimplementedError();
  }
}
