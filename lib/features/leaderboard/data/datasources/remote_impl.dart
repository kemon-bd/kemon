import '../../../../core/shared/shared.dart';
import '../../leaderboard.dart';

class LeaderboardRemoteDataSourceImpl extends LeaderboardRemoteDataSource {
  final Client client;

  LeaderboardRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<List<LeaderModel>> find({
    required DateTime from,
    required DateTime to,
  }) async {
    /// ! Real API
    final Map<String, String> headers = {
      "from": from.MMddyyyy,
      "to": to.MMddyyyy,
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };
    final response = await client.get(RemoteEndpoints.leaderboardStanding, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      final leaders = List<Map<String, dynamic>>.from(json.decode(response.body))
          .map(
            (e) => LeaderModel.parse(map: e),
          )
          .toList();
      return leaders;
    } else {
      throw RemoteFailure(message: response.body);
    }
  }
}
