import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../industry.dart';

typedef IndustryResponse = ({IndustryModel industry, List<CategoryModel> categories});

class IndustryRemoteDataSourceImpl extends IndustryRemoteDataSource {
  final Client client;

  IndustryRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<List<IndustryModel>> find() async {
    final Response response = await client.get(
      RemoteEndpoints.industries,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<Map<String, dynamic>> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final List<dynamic> data = networkResponse.result!["industries"];

        return data.map((map) => IndustryModel.parse(map: map)).toList();
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load categories');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load categories');
    }
  }
}
