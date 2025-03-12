import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../category/category.dart';
import '../../../industry/industry.dart';
import '../../../location/location.dart';
import '../../../sub_category/sub_category.dart';
import '../../search.dart';

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final Client client;

  SearchRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<SearchResults> result({
    required String query,
    required FilterOptions filter,
  }) async {
    final Map<String, String> headers = {
      'query': query,
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };

    if (filter.sortBy != null) {
      headers['sortby'] = filter.sortBy.value;
    }
    if (filter.filterBy != null) {
      headers['filterby'] = filter.filterBy!;
    }
    if (filter.division != null) {
      headers['division'] = filter.division!;
    }
    if (filter.district != null) {
      headers['district'] = filter.district!;
    }
    if (filter.thana != null) {
      headers['thana'] = filter.thana!;
    }
    if (filter.industry != null) {
      headers['industry'] = filter.industry!;
    }
    if (filter.category != null) {
      headers['category'] = filter.category!;
    }
    if (filter.subCategory != null) {
      headers['subcategory'] = filter.subCategory!;
    }

    final response = await client.get(
      RemoteEndpoints.searchResults,
      headers: headers,
    );

    final RemoteResponse<Map<String, dynamic>> result = RemoteResponse.parse(
      response: response,
    );

    if (result.success) {
      final List<dynamic> businessesMap = result.result!['listingDatas'];
      final List<dynamic> subCategoriesMap = result.result!['relatedDatas'];
      final List<dynamic> locationsMap = result.result!['locationDatas'];

      final List<BusinessLiteModel> businesses = businessesMap
          .map<BusinessLiteModel>(
            (map) => BusinessLiteModel.parse(map: map),
          )
          .toList();
      final List<LocationModel> locations = locationsMap
          .map(
            (map) => LocationModel.parse(map: map),
          )
          .toList();
      final List<SubCategoryModel> subCategories = subCategoriesMap
          .map(
            (map) => SubCategoryModel.parse(map: map),
          )
          .toList();

      return (
        businesses: businesses,
        locations: locations,
        subCategories: subCategories,
      );
    } else {
      throw RemoteFailure(message: result.error!);
    }
  }

  @override
  Future<List<SearchSuggestionModel>> suggestion({
    required String query,
  }) async {
    try {
      final Map<String, String> headers = {
        'query': Uri.encodeComponent(query),
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptCharsetHeader: 'utf-8',
      };

      final response = await client.get(
        RemoteEndpoints.searchSuggestions,
        headers: headers,
      );

      if (HttpStatus.ok == response.statusCode) {
        final List<Map<String, dynamic>> map = List<Map<String, dynamic>>.from(json.decode(response.body));
        final List<SearchSuggestionModel> suggestions = map.map(
          (map) {
            final SuggestionType type = SuggestionType.values.elementAt(map['type'] as int);

            switch (type) {
              case SuggestionType.listing:
                return BusinessSuggestionModel.parse(map: map);
              case SuggestionType.industry:
                return IndustrySuggestionModel.parse(map: map);
              case SuggestionType.category:
                return CategorySuggestionModel.parse(map: map);
              case SuggestionType.subCategory:
                return SubCategorySuggestionModel.parse(map: map);
            }
          },
        ).toList();

        return suggestions;
      } else {
        throw RemoteFailure(message: response.body);
      }
    } on SocketException {
      throw NoInternetFailure();
    }
  }
}
