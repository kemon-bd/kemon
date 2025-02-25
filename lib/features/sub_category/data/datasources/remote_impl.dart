import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

class SubCategoryRemoteDataSourceImpl extends SubCategoryRemoteDataSource {
  final Client client;

  SubCategoryRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<List<SubCategoryModel>> category({
    required String category,
  }) async {
    final Map<String, String> headers = {
      'categoryGuid': category,
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };

    final Response response = await client.get(
      RemoteEndpoints.subCategories,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<Map<String, dynamic>> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final List<dynamic> data = networkResponse.result!["subCategories"];

        return data.map((e) => SubCategoryModel.parse(map: e)).toList();
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load categories');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load categories');
    }
  }
}
