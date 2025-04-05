import '../../../../core/shared/shared.dart';
import '../../industry.dart';

class IndustryRemoteDataSourceImpl extends IndustryRemoteDataSource {
  final Client client;

  IndustryRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<List<IndustryModel>> find() async {
    final Response response = await client.get(
      RemoteEndpoints.allIndustries,
    );

    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> data = json.decode(response.body);

      return data.map((map) => IndustryModel.parse(map: map)).toList();
    } else {
      throw RemoteFailure(message: response.body);
    }
  }

  @override
  FutureOr<List<IndustryWithListingCountModel>> location({
    required String division,
    String? district,
    String? thana,
  }) async {
    final Map<String, String> headers = {
      "division": Uri.encodeComponent(division),
      "district": Uri.encodeComponent(district ?? ''),
      "thana": Uri.encodeComponent(thana ?? ''),
    };
    final Response response = await client.get(
      RemoteEndpoints.locationBasedIndustriesFilter,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final List<dynamic> data = List<dynamic>.from(json.decode(response.body));

      return data.map((map) => IndustryWithListingCountModel.parse(map: map)).toList();
    } else {
      throw RemoteFailure(message: response.body);
    }
  }
}
