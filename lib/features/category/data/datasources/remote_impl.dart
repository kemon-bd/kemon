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
    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };
    final Response response = await client.get(
      RemoteEndpoints.featuredCategories,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<Map<String, dynamic>> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final List<dynamic> data = networkResponse.result!["featuredCategories"];

        return data.map((e) => CategoryModel.parse(map: e)).toList();
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load categories');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load categories');
    }
  }

  @override
  FutureOr<List<IndustryWithListingCountModel>> all({
    required String? query,
  }) async {
    final Map<String, String> headers = {
      'query': query ?? '',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };
    final Response response = await client.get(
      RemoteEndpoints.allCategories,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> data = List<dynamic>.from(json.decode(response.body));

      return data.map((map) => IndustryWithListingCountModel.parse(map: map)).toList();
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load categories');
    }
  }

  @override
  FutureOr<List<CategoryModel>> industry({
    required String urlSlug,
  }) async {
    final Map<String, String> headers = {
      'industryslug': urlSlug,
      'pageno': "1",
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };
    final Response response = await client.get(
      RemoteEndpoints.categories,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<Map<String, dynamic>> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final List<dynamic> data = networkResponse.result!["categoryModelCombinedList"];
        final result = data
            .map(
              (map) => List<dynamic>.from(map['categories']).map((cat) => CategoryModel.parse(map: cat)).toList(),
            )
            .toList();

        return result.expand((list) => list).toList();
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load categories');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load categories');
    }
  }

  @override
  FutureOr<CategoryModel> find({
    required String urlSlug,
  }) async {
    final Map<String, String> headers = {
      'urlSlug': urlSlug,
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };
    final Response response = await client.get(
      RemoteEndpoints.findCategory,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<Map<String, dynamic>> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final List<dynamic> data = networkResponse.result!["categoryModelCombinedList"];

        return CategoryModel.parse(map: List<dynamic>.from(data.first['categories']).first);
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load categories');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load categories');
    }
  }

}
