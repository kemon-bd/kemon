import '../../../../core/shared/shared.dart';
import '../../location.dart';

class LocationRemoteDataSourceImpl extends LocationRemoteDataSource {
  final Client client;

  LocationRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<List<LocationModel>> featured() async {
    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };

    final Response response = await client.get(RemoteEndpoints.featuredLocations, headers: headers);

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<List<dynamic>> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final List<dynamic> data = networkResponse.result!;

        return data.map((e) => LocationModel.parse(map: e)).toList();
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load locations');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load locations');
    }
  }

  @override
  FutureOr<LocationModel> find({
    required String urlSlug,
  }) async {
    final Map<String, String> headers = {
      'urlSlug': urlSlug,
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };
    final Response response = await client.get(
      RemoteEndpoints.findLocation,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<Map<String, dynamic>> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final List<dynamic> data = networkResponse.result!["locationModelCombinedList"];

        return LocationModel.parse(map: List<dynamic>.from(data.first['locations']).first);
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load locations');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load locations');
    }
  }

  @override
  FutureOr<List<DivisionWithListingCountModel>> all({
    required String? query,
  }) async {
    final Map<String, String> headers = {
      'query': query ?? '',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };
    final Response response = await client.get(
      RemoteEndpoints.allLocations,
      headers: headers,
    );
    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> data = List<dynamic>.from(jsonDecode(response.body));

      return data.map((map) => DivisionWithListingCountModel.parse(map: map)).toList();
    } else {
      throw RemoteFailure(message: response.body);
    }
  }

  @override
  FutureOr<List<DivisionWithListingCountModel>> category({
    required Identity industry,
    Identity? category,
    Identity? subCategory,
  }) async {
    final Map<String, String> headers = {
      'industry': industry.guid,
      'category': category?.guid ?? '',
      'subCategory': subCategory?.guid ?? '',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };
    final Response response = await client.get(
      RemoteEndpoints.categoryBasedLocationsFilter,
      headers: headers,
    );
    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> data = List<dynamic>.from(jsonDecode(response.body));

      return data.map((map) => DivisionWithListingCountModel.parse(map: map)).toList();
    } else {
      throw RemoteFailure(message: response.body);
    }
  }
}
