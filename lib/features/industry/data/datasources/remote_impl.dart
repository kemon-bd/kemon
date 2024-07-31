import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../industry.dart';

typedef IndustryResponse = ({
  IndustryModel industry,
  List<CategoryModel> categories
});

class IndustryRemoteDataSourceImpl extends IndustryRemoteDataSource {
  final Client client;

  IndustryRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<List<IndustryResponse>> find() async {
    final Map<String, String> headers = {};

    final Response response = await client.get(
      RemoteEndpoints.industries,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<Map<String, dynamic>> networkReponse =
          RemoteResponse.parse(response: response);

      if (networkReponse.success) {
        final List<dynamic> data =
            networkReponse.result!["categoryModelCombinedList"];

        return data.map(
          (i) {
            final List<dynamic> categories = i['categories'];
            final Map<String, dynamic> map = i['industry'];
            map['categories'] = categories;
            return (
              industry: IndustryModel.parse(map: map),
              categories:
                  categories.map((c) => CategoryModel.parse(map: c)).toList()
            );
          },
        ).toList();
      } else {
        throw RemoteFailure(
            message: networkReponse.error ?? 'Failed to load categories');
      }
    } else {
      throw RemoteFailure(
          message: response.reasonPhrase ?? 'Failed to load categories');
    }
  }
}
