import '../../../../core/shared/shared.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
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
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required SubCategoryEntity? subCategory,
    required List<int> ratings,
  }) async {
    final Map<String, String> headers = {
      'urlSlug': urlSlug,
      'pageno': '$page',
      'division': division?.value ?? '',
      'district': district?.value ?? '',
      'thana': thana?.value ?? '',
      'subcategoryslug': subCategory?.urlSlug ?? '',
      'sortby': sort.value,
      'rating': ratings.join(','),
    };

    final Response response = await client.get(
      RemoteEndpoints.listingsByCategory,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<Map<String, dynamic>> networkResponse =
          RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final List<dynamic> businesses =
            List<dynamic>.from(networkResponse.result!["listingDatas"]);
        final List<dynamic> relatedCategories =
            List<dynamic>.from(networkResponse.result!["relatedDatas"]);
        final int total = networkResponse.result!["totalCount"];

        return (
          businesses:
              businesses.map((e) => BusinessModel.parse(map: e)).toList(),
          total: total,
          related: relatedCategories
              .map((e) => SubCategoryModel.parse(map: e))
              .toList(),
        );
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
      final RemoteResponse<dynamic> networkResponse =
          RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final Map<String, dynamic> data =
            networkResponse.result as Map<String, dynamic>;

        return BusinessModel.parse(map: data);
      } else {
        throw RemoteFailure(
            message: networkResponse.error ?? 'Failed to load business');
      }
    } else {
      throw RemoteFailure(
          message: response.reasonPhrase ?? 'Failed to load business');
    }
  }
}
