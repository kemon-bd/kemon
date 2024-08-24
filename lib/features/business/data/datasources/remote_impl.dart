import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessRemoteDataSourceImpl extends BusinessRemoteDataSource {
  final Client client;

  BusinessRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<BusinessesByCategoryPaginatedResponse> category({
    required int page,
    required String urlSlug,
  }) async {
    final Map<String, String> headers = {
      'urlSlug': urlSlug,
      'pageno': '$page',
    };

    final Response response = await client.get(
      RemoteEndpoints.listingsByCategory,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<Map<String, dynamic>> networkReponse = RemoteResponse.parse(response: response);

      if (networkReponse.success) {
        final List<dynamic> data = List<dynamic>.from(networkReponse.result!["listingDatas"]);
        final int total = networkReponse.result!["totalCount"];

        return (
          businesses: data.map((e) => BusinessModel.parse(map: e)).toList(),
          total: total,
        );
      } else {
        throw RemoteFailure(message: networkReponse.error ?? 'Failed to load categories');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load categories');
    }
  }

  @override
  FutureOr<BusinessModel> find({
    required String urlSlug,
  }) async {
    final Map<String, String> headers = {
      'urlslug': Uri.encodeComponent(urlSlug),
    };

    final Response response = await client.get(
      RemoteEndpoints.findListing,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<dynamic> networkReponse = RemoteResponse.parse(response: response);

      if (networkReponse.success) {
        final Map<String, dynamic> data = networkReponse.result as Map<String, dynamic>;

        return BusinessModel.parse(map: data);
      } else {
        throw RemoteFailure(message: networkReponse.error ?? 'Failed to load business');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load business');
    }
  }
}
