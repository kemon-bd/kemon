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
    };

    if (filter.sortBy != null) {
      headers['sortby'] = filter.sortBy!;
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

      final List<BusinessModel> businesses = businessesMap
          .map(
            (map) => BusinessModel.parse(map: map),
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
  Future<AutoCompleteSuggestions> suggestion({
    required String query,
  }) async {
    final Map<String, String> headers = {
      'Searchtext': query,
    };

    final response = await client.get(
      RemoteEndpoints.searchSuggestion,
      headers: headers,
    );

    final RemoteResponse<Map<String, dynamic>> result = RemoteResponse.parse(
      response: response,
    );

    if (result.success) {
      final List<dynamic> businessesMap = result.result!['listing'];
      final List<dynamic> industriesMap = result.result!['industry'];
      final List<dynamic> categoriesMap = result.result!['category'];
      final List<dynamic> subCategoriesMap = result.result!['subcategory'];

      final List<BusinessModel> businesses = businessesMap
          .map(
            (map) => BusinessModel.parse(map: map),
          )
          .toList();
      final List<IndustryModel> industries = industriesMap
          .map(
            (map) => IndustryModel.parse(map: map),
          )
          .toList();
      final List<CategoryModel> categories = categoriesMap
          .map(
            (map) => CategoryModel.parse(map: map),
          )
          .toList();
      final List<SubCategoryModel> subCategories = subCategoriesMap
          .map(
            (map) => SubCategoryModel.parse(map: map),
          )
          .toList();

      return (
        businesses: businesses,
        industries: industries,
        categories: categories,
        subCategories: subCategories,
      );
    } else {
      throw RemoteFailure(message: result.error!);
    }
  }
}
