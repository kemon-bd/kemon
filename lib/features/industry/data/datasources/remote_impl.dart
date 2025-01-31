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
  FutureOr<List<IndustryResponse>> find() async {
    int page = 1;
    int total = 0;
    final List<IndustryResponse> responses = [];
    final List<CategoryEntity> categories = [];

    do {
      final result = await paginated(page: page);
      total = result.$1;
      responses.addAll(result.$2);

      categories.addAll(result.$2.expand((row) => row.categories).toList());
      page++;
    } while (categories.length < total);
    return responses;
  }

  Future<(int total, List<IndustryResponse>)> paginated({required int page}) async {
    final Map<String, String> headers = {};

    final Response response = await client.get(
      RemoteEndpoints.industries,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<Map<String, dynamic>> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final int total = networkResponse.result!['totalCount'];
        final List<dynamic> data = networkResponse.result!["categoryModelCombinedList"];

        return (
          total,
          data.map(
            (i) {
              final List<dynamic> categories = i['categories'];
              final Map<String, dynamic> map = i['industry'];
              map['categories'] = categories;
              return (
                industry: IndustryModel.parse(map: map),
                categories: categories.map((c) => CategoryModel.parse(map: c)).toList()
              );
            },
          ).toList(),
        );
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load categories');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load categories');
    }
  }
}
