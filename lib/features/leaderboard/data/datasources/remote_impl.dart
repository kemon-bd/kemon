import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class LeaderboardRemoteDataSourceImpl extends LeaderboardRemoteDataSource {
  final Client client;

  LeaderboardRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<LeaderboardResponse> find({
    required int page,
    required String query,
    required DateTime from,
    required DateTime to,
  }) async {
    /// ! Real API
    /// final Map<String, String> headers = {
    ///   "page": page.toString(),
    ///   "query": query,
    ///   "from": from.toIso8601String(),
    ///   "to": to.toIso8601String(),
    /// };
    /// final response = await client.get(RemoteEndpoints.leaderboard, headers: headers);
    ///
    /// ? MOCKED VERSION
    final content = await rootBundle.loadString('api/leaderboard.json');
    final response = Response(content, HttpStatus.ok);

    final RemoteResponse<Map<String, dynamic>> remote =
        RemoteResponse.parse(response: response);

    if (remote.success) {
      final int total = remote.result!['total'];
      final DateTime deadline = DateTime.parse(remote.result!['deadline']);
      final List<LeaderEntity> leaders =
          List<dynamic>.from(remote.result!['leaders'])
              .map(
                (e) => LeaderModel.parse(map: e),
              )
              .toList();
      return (
        total: total,
        deadline: deadline,
        leaders: leaders,
      );
    } else {
      throw RemoteFailure(message: remote.error ?? response.body);
    }
  }
}
