import '../../../../core/shared/shared.dart';
import '../../category.dart';

class CategoryRemoteDataSourceImpl extends CategoryRemoteDataSource {
  final Client client;

  CategoryRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<List<CategoryModel>> featured() async {
    final Map<String, String> headers = {};
    final Response response = await client.get(
      RemoteEndpoints.featuredCategories,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<Map<String, dynamic>> networkReponse = RemoteResponse.parse(response: response);

      if (networkReponse.success) {
        final List<dynamic> data = networkReponse.result!["featuredCategories"];

        return data.map((e) => CategoryModel.parse(map: e)).toList();
      } else {
        throw RemoteFailure(message: networkReponse.error ?? 'Failed to load categories');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load categories');
    }
  }
}
