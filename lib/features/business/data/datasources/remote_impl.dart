import 'package:kemon/features/industry/domain/entities/industry.dart';

import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../lookup/lookup.dart';
import '../../../review/review.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

class BusinessRemoteDataSourceImpl extends BusinessRemoteDataSource {
  final Client client;

  BusinessRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<List<BusinessLiteModel>> category({
    required Identity industry,
    required Identity? category,
    required Identity? subCategory,
    required String? division,
    required String? district,
    required String? thana,
    required String? query,
    required SortBy? sort,
    required RatingRange ratings,
  }) async {
    final Map<String, String> headers = {
      'search': Uri.encodeComponent(query ?? ''),
      'division': division ?? '',
      'district': district ?? '',
      'thana': thana ?? '',
      'industry': industry.guid,
      'category': category?.guid ?? '',
      'subCategory': subCategory?.guid ?? '',
      'sort': sort.value,
      'rating': ratings.value,
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };

    final Response response = await client.get(
      RemoteEndpoints.categoryBasedListings,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final List<Map<String, dynamic>> payload = List<Map<String, dynamic>>.from(json.decode(response.body));

      return payload.map((e) => BusinessLiteModel.parse(map: e)).toList();
    } else {
      throw RemoteFailure(message: response.body);
    }
  }

  @override
  FutureOr<List<BusinessLiteModel>> location({
    required String division,
    String? district,
    String? thana,
    required String? query,
    required Identity? industry,
    required Identity? category,
    required Identity? subCategory,
    required SortBy? sort,
    required RatingRange ratings,
  }) async {
    final Map<String, String> headers = {
      'division': Uri.encodeComponent(division),
      'district': Uri.encodeComponent(district ?? ''),
      'thana': Uri.encodeComponent(thana ?? ''),
      'search': Uri.encodeComponent(query ?? ''),
      'industry': industry?.guid ?? '',
      'category': category?.guid ?? '',
      'subCategory': subCategory?.guid ?? '',
      'sort': sort.value,
      'rating': ratings.value,
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };

    final Response response = await client.get(
      RemoteEndpoints.locationBasedListings,
      headers: headers,
    );
    if (response.statusCode == HttpStatus.ok) {
      final List<Map<String, dynamic>> payload = List<Map<String, dynamic>>.from(json.decode(response.body));

      return payload.map((e) => BusinessLiteModel.parse(map: e)).toList();
    } else {
      throw RemoteFailure(message: response.body);
    }
  }

  @override
  FutureOr<ListingModel> find({
    required String urlSlug,
    required Identity? user,
  }) async {
    final Map<String, String> headers = {
      'urlSlug': Uri.encodeComponent(urlSlug),
      'user': user?.guid ?? '',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };

    final Response response = await client.get(
      RemoteEndpoints.listing,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final Map<String, dynamic> data = json.decode(response.body);
      final BusinessModel business = BusinessModel.parse(map: data['listing']);
      final BusinessRatingInsightsModel insights = BusinessRatingInsightsModel.parse(map: data['insights']);
      final reviews = (data['reviews'] as List).map((map) => ListingReviewModel.parse(map: map)).toList();
      final ListingModel model = (business, insights, reviews);
      return model;
    } else {
      throw RemoteFailure(message: response.body);
    }
  }

  @override
  FutureOr<void> validateUrlSlug({
    required String urlSlug,
  }) async {
    final Map<String, String> headers = {
      'url': urlSlug.paramCase,
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
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
  FutureOr<void> publish({
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
      'Name': Uri.encodeComponent(name),
      'URLSlug': Uri.encodeComponent(urlSlug),
      'Type': type.name,
      'Description': Uri.encodeComponent(about),
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
      request.files.add(await MultipartFile.fromPath('Files', logo.path));
    }
    final StreamedResponse streamedResponse = await request.send();
    final response = await Response.fromStream(streamedResponse);

    if (response.statusCode == HttpStatus.ok) {
      final networkResponse = RemoteResponse.parse(response: response);
      if (networkResponse.success) {
        return;
      } else {
        throw RemoteFailure(message: networkResponse.error ?? response.reasonPhrase ?? "Something went wrong.");
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to add review');
    }
  }
}
