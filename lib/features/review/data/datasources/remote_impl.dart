import '../../../../core/shared/shared.dart';
import '../../review.dart';

class ReviewRemoteDataSourceImpl extends ReviewRemoteDataSource {
  final Client client;

  ReviewRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<void> create({
    required String token,
    required Identity user,
    required Identity listing,
    required double rating,
    required String title,
    required String description,
    required String date,
    required List<XFile> attachments,
  }) async {
    final request = MultipartRequest('POST', RemoteEndpoints.addReview);
    request.headers.addAll({
      'UserId': user.guid,
      'ListingGuid': listing.guid,
      'Rating': rating.round().toString(),
      'Title': Uri.encodeComponent(title),
      'Description': Uri.encodeComponent(description),
      'DateOfExperience': date,
    });
    for (XFile file in attachments) {
      request.files.add(await MultipartFile.fromPath('files', file.path));
    }
    final StreamedResponse streamedResponse = await request.send();
    final response = await Response.fromStream(streamedResponse);

    if (response.statusCode == HttpStatus.ok) {
      return;
    } else {
      throw RemoteFailure(
          message: response.reasonPhrase ?? 'Failed to add review');
    }
  }

  @override
  FutureOr<void> delete({
    required String token,
    required Identity user,
    required Identity review,
  }) async {
    final Map<String, String> headers = {
      'userGuid': user.guid,
      'reviewGuid': review.guid,
    };

    final Response response = await client.delete(
      RemoteEndpoints.deleteReview,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<void> networkReponse = RemoteResponse.parse(response: response);

      if (networkReponse.success) {
        return;
      } else {
        throw RemoteFailure(message: networkReponse.error ?? 'Failed to delete review');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to delete review');
    }
  }

  @override
  Future<ReviewDetailsModel> rating({
    required String urlSlug,
  }) async {
    final Map<String, String> headers = {
      'urlslug': urlSlug,
    };

    final Response response = await client.get(
      RemoteEndpoints.reviewDetails,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<dynamic> networkReponse = RemoteResponse.parse(response: response);

      if (networkReponse.success) {
        final Map<String, dynamic> data = networkReponse.result as Map<String, dynamic>;

        return ReviewDetailsModel.parse(map: data);
      } else {
        throw RemoteFailure(message: networkReponse.error ?? 'Failed to load review details');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load review details');
    }
  }

  @override
  FutureOr<List<ReviewModel>> find({
    required Identity user,
  }) async {
    final Map<String, String> headers = {
      'userGuid': user.guid,
    };

    final Response response = await client.get(
      RemoteEndpoints.userReviews,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<List<dynamic>> networkReponse = RemoteResponse.parse(response: response);

      if (networkReponse.success) {
        final List<dynamic> data = networkReponse.result as List<dynamic>;

        return data.map((e) => ReviewModel.parse(map: e)).toList();
      } else {
        throw RemoteFailure(message: networkReponse.error ?? 'Failed to load business');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load business');
    }
  }

  @override
  FutureOr<void> update({
    required String token,
    required Identity user,
    required ReviewEntity review,
  }) async {
    final Map<String, String> headers = {
      'userGuid': user.guid,
      'reviewGuid': review.identity.guid,
      'title': review.title,
      'description': review.description ?? '',
      'date': review.date.toUtc().toIso8601String(),
    };

    final Response response = await client.post(
      RemoteEndpoints.addReview,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<void> networkReponse = RemoteResponse.parse(response: response);

      if (networkReponse.success) {
        return;
      } else {
        throw RemoteFailure(message: networkReponse.error ?? 'Failed to add review');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to add review');
    }
  }

  @override
  Future<List<ReviewModel>> recent() async {
    final Map<String, String> headers = {};

    final Response response = await client.get(
      RemoteEndpoints.recentReviews,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<List<dynamic>> networkReponse = RemoteResponse.parse(response: response);

      if (networkReponse.success) {
        final List<dynamic> data = networkReponse.result as List<dynamic>;

        return data.map((e) => ReviewModel.parse(map: e)).toList();
      } else {
        throw RemoteFailure(message: networkReponse.error ?? 'Failed to load business');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load business');
    }
  }
}
