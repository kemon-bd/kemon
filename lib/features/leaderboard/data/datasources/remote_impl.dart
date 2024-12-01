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
    final Map<String, String> headers = {
      "pageno": page.toString(),
      "query": query,
      "startdate": from.MMddyyyy,
      "enddate": to.MMddyyyy,
    };
    final response = await client.get(RemoteEndpoints.leaderboard, headers: headers);

    ///
    /// ? MOCKED VERSION
    // final content = await rootBundle.loadString('api/leaderboard.json');
    // final response = Response(content, HttpStatus.ok);

    final RemoteResponse<Map<String, dynamic>> remote = RemoteResponse.parse(response: response);

    if (remote.success) {
      final int total = remote.result!['totalCount'] ?? 0;
      // final DateTime deadline = DateTime.parse(remote.result!['deadline']);
      final List<LeaderEntity> leaders = List<dynamic>.from(remote.result!['leaderboards'] ?? [])
          .map(
            (e) => LeaderModel.parse(map: e),
          )
          .toList();
      return (
        total: total,
        deadline: DateTime.now(),
        leaders: leaders,
      );
    } else {
      throw RemoteFailure(message: remote.error ?? response.body);
    }
  }
}
