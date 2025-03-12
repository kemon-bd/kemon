import '../../../../core/shared/shared.dart';
import '../../home.dart';
import '../../../business/business.dart';
import '../../../category/category.dart';
import '../../../location/location.dart';
import '../../../review/review.dart';

class HomeRemoteDatasourceImpl extends HomeRemoteDatasource {
  final Client client;

  HomeRemoteDatasourceImpl({required this.client});

  @override
  Future<OverviewResponseModel> find({
    required Identity? user,
  }) async {
    final Map<String, String> headers = {
      "user": user?.guid ?? "",
    };

    final response = await client.get(
      RemoteEndpoints.overview,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final categories = (data['categories'] as List).map((map) => CategoryModel.parse(map: map)).toList();
      final locations = (data['locations'] as List).map((map) => ThanaModel.parse(map: map)).toList();
      final reviews = (data['reviews'] as List).map((map) => RecentReviewModel.parse(map: map)).toList();
      final listings = (data['listings'] as List).map((map) => BusinessLiteModel.parse(map: map)).toList();

      final OverviewResponseModel model = (
        categories,
        locations,
        reviews,
        listings,
      );

      return model;
    }
    throw RemoteFailure(message: response.body);
  }
}
