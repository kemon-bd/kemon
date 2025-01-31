import 'package:kemon/features/industry/domain/entities/industry.dart';

import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../location/location.dart';
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
    required String? query,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required CategoryEntity? category,
    required SubCategoryEntity? subCategory,
    required List<int> ratings,
  }) async {
    final Map<String, String> headers = {
      'urlSlug': urlSlug,
      'query': query ?? '',
      'pageno': '$page',
      'division': division?.value ?? '',
      'district': district?.value ?? '',
      'thana': thana?.value ?? '',
      'categoryslug': category?.urlSlug ?? '',
      'subcategoryslug': subCategory?.urlSlug ?? '',
      'sortby': sort.value,
      'rating': ratings.join(','),
    };

    final Response response = await client.get(
      RemoteEndpoints.listingsByCategory,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<Map<String, dynamic>> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final List<dynamic> businesses = List<dynamic>.from(networkResponse.result!["listingDatas"]);
        final List<dynamic> relatedCategories = List<dynamic>.from(networkResponse.result!["relatedDatas"]);
        final int total = networkResponse.result!["totalCount"];

        return (
          businesses: businesses.map((e) => BusinessModel.parse(map: e)).toList(),
          total: total,
          related: relatedCategories.map((e) => SubCategoryModel.parse(map: e)).toList(),
        );
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load categories');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load categories');
    }
  }

  @override
  FutureOr<BusinessesByLocationPaginatedResponse> location({
    required int page,
    required String location,
    required String? division,
    required String? district,
    required String? thana,
    required String? query,
    required SortBy? sort,
    required List<int> ratings,
    required CategoryEntity? category,
    required SubCategoryEntity? sub,
  }) async {
    final Map<String, String> headers = {
      'urlSlug': location.toLowerCase().trim(),
      'division': division?.toLowerCase().trim() ?? '',
      'district': district?.toLowerCase().trim() ?? '',
      'thana': thana?.toLowerCase().trim() ?? '',
      'query': query ?? '',
      'pageno': '$page',
      'sortby': sort.value,
      'rating': ratings.join(','),
      'categoryslug': category?.urlSlug ?? '',
      'subcategoryslug': sub?.urlSlug ?? '',
    };

    final Response response = await client.get(
      RemoteEndpoints.listingsByLocation,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<Map<String, dynamic>> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final List<dynamic> businesses = List<dynamic>.from(networkResponse.result!["listingDatas"] ?? []);
        final List<dynamic> relatedCategories = List<dynamic>.from(networkResponse.result!["relatedDatas"] ?? []);
        final int total = networkResponse.result!["totalCount"];

        return (
          businesses: businesses.map((e) => BusinessModel.parse(map: e)).toList(),
          total: total,
          related: relatedCategories.map((e) => LocationModel.parse(map: e)).toList(),
        );
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load categories');
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
      final RemoteResponse<dynamic> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final Map<String, dynamic> data = networkResponse.result as Map<String, dynamic>;

        return BusinessModel.parse(map: data);
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load business');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load business');
    }
  }

  @override
  FutureOr<void> validateUrlSlug({
    required String urlSlug,
  }) async {
    final Map<String, String> headers = {
      'url': urlSlug.paramCase,
    };

    final Response response = await client.get(
      RemoteEndpoints.validateUrlSlug,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<dynamic> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        return;
      } else {
        throw InvalidUrlSlugFailure(networkResponse.error);
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load business');
    }
  }

  @override
  FutureOr<String> publish({
    required String token,
    required Identity user,
    required String name,
    required String urlSlug,
    required String about,
    required XFile? logo,
    required ListingType type,
    required String phone,
    required String email,
    required String website,
    required String social,
    required IndustryEntity industry,
    required CategoryEntity? category,
    required SubCategoryEntity? subCategory,
    required String address,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
  }) async {
    final request = MultipartRequest('POST', RemoteEndpoints.addListing);
    request.headers.addAll({
      'authorization': token,
      'UserId': user.guid,
      'Name': name,
      'URLSlug': urlSlug,
      'Type': type.name,
      'Description': about,
      'Website': website,
      'Email': email,
      'Phone': phone,
      'Division': division?.value ?? '',
      'District': district?.value ?? '',
      'Thana': thana?.value ?? '',
      'Address': address,
      'IndustryGuid': industry.identity.guid,
      'CategoryGuid': category?.identity.guid ?? '',
      'SubCategoryGuid': subCategory?.identity.guid ?? '',
      'SocialProfile': social,
      HttpHeaders.contentTypeHeader: 'multipart/form-data',
    });
    if (logo != null) {
      request.files.add(await MultipartFile.fromPath('File', logo.path));
    }
    final StreamedResponse streamedResponse = await request.send();
    final response = await Response.fromStream(streamedResponse);

    if (response.statusCode == HttpStatus.ok) {
      final networkResponse = RemoteResponse.parse(response: response);
      if (networkResponse.success) {
        return networkResponse.result!["urlSlug"] ;
      } else {
        throw RemoteFailure(message: networkResponse.error ?? response.reasonPhrase ?? "Something went wrong.");
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to add review');
    }
  }
}
