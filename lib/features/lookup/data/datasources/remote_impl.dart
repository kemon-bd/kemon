import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

class LookupRemoteDataSourceImpl extends LookupRemoteDataSource {
  final Client client;

  LookupRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<List<LookupModel>> find({
    required LookupKey key,
    String? parent,
  }) async {
    final Map<String, String> headers = {
      'datakey': key.key.dataKey,
    };
    if (parent != null) {
      headers['parentkey'] = parent;
    }

    final Response response = await client.get(
      RemoteEndpoints.lookup,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<List<dynamic>> networkResponse =
          RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        return networkResponse.result!.map((e) {
          return LookupModel.parse(map: e);
        }).toList();
      } else {
        throw RemoteFailure(
            message: networkResponse.error ?? 'Failed to load categories');
      }
    } else {
      throw RemoteFailure(
          message: response.reasonPhrase ?? 'Failed to load categories');
    }
  }
}
