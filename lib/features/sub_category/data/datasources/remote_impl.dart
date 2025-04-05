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
      'category': category,
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };

    final Response response = await client.get(
      RemoteEndpoints.subCategoriesByCategory,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((map) => SubCategoryModel.parse(map: map)).toList();
    } else {
      throw RemoteFailure(message: response.body);
    }
  }
}
