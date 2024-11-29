import '../../../../core/shared/shared.dart';
import '../../../industry/industry.dart';
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
      final RemoteResponse<Map<String, dynamic>> networkResponse =
          RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final List<dynamic> data =
            networkResponse.result!["featuredCategories"];

        return data.map((e) => CategoryModel.parse(map: e)).toList();
      } else {
        throw RemoteFailure(
            message: networkResponse.error ?? 'Failed to load categories');
      }
    } else {
      throw RemoteFailure(
          message: response.reasonPhrase ?? 'Failed to load categories');
    }
  }

  @override
  FutureOr<CategoryPaginatedResponse> all({
    required int page,
    required String? industry,
    required String? query,
  }) async {
    final Map<String, String> headers = {
      'query': query ?? '',
      'industry': industry ?? '',
      'pageno': page.toString(),
    };
    final Response response = await client.get(
      RemoteEndpoints.industries,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<Map<String, dynamic>> networkResponse =
          RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final int total = networkResponse.result!["totalCount"];
        final List<dynamic> data =
            networkResponse.result!["categoryModelCombinedList"];
        final result = data
            .map(
              (map) => (
                industry: IndustryModel.parse(map: map['industry']),
                categories: List<dynamic>.from(map['categories'])
                    .map((cat) => CategoryModel.parse(map: cat))
                    .toList(),
              ),
            )
            .toList();

        return (total: total, results: result);
      } else {
        throw RemoteFailure(
            message: networkResponse.error ?? 'Failed to load categories');
      }
    } else {
      throw RemoteFailure(
          message: response.reasonPhrase ?? 'Failed to load categories');
    }
  }

  @override
  FutureOr<CategoryModel> find({
    required String urlSlug,
  }) async {
    final Map<String, String> headers = {
      'urlSlug': urlSlug,
    };
    final Response response = await client.get(
      RemoteEndpoints.findCategory,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<Map<String, dynamic>> networkResponse =
          RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final List<dynamic> data =
            networkResponse.result!["categoryModelCombinedList"];

        return CategoryModel.parse(
            map: List<dynamic>.from(data.first['categories']).first);
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
