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
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to add review');
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
      'id': review.id.toString(),
    };

    final Response response = await client.delete(
      RemoteEndpoints.deleteReview,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<void> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        return;
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to delete review');
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
      'urlslug': Uri.encodeComponent(urlSlug),
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };

    final Response response = await client.get(
      RemoteEndpoints.reviewDetails,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<dynamic> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final Map<String, dynamic> data = networkResponse.result as Map<String, dynamic>;

        return ReviewDetailsModel.parse(map: data);
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load review details');
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
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };

    final Response response = await client.get(
      RemoteEndpoints.userReviews,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<List<dynamic>> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final List<dynamic> data = networkResponse.result as List<dynamic>;

        return data.map((e) => ReviewModel.parse(map: e)).toList();
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load business');
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
    required Identity listing,
    required List<XFile> attachments,
  }) async {
    final request = MultipartRequest('POST', RemoteEndpoints.addReview);
    request.headers.addAll({
      'id': review.identity.id.toString(),
      'UserId': user.guid,
      'ListingGuid': listing.guid,
      'Rating': review.rating.round().toString(),
      'Title': Uri.encodeComponent(review.title),
      'Description': Uri.encodeComponent(review.description ?? ''),
      'DateOfExperience': review.experiencedAt.toIso8601String(),
    });
    for (XFile file in attachments) {
      request.files.add(await MultipartFile.fromPath('files', file.path));
    }
    final StreamedResponse streamedResponse = await request.send();
    final response = await Response.fromStream(streamedResponse);

    if (response.statusCode == HttpStatus.ok) {
      return;
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to add review');
    }
  }

  @override
  Future<List<ReviewModel>> recent() async {
    final Map<String, String> headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };

    final Response response = await client.get(
      RemoteEndpoints.recentReviews,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<List<dynamic>> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final List<dynamic> data = networkResponse.result as List<dynamic>;

        return data.map((e) => ReviewModel.parse(map: e)).toList();
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load business');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load business');
    }
  }

  @override
  FutureOr<List<ReactionModel>> reactions({
    required Identity review,
  }) async {
    final Map<String, String> headers = {
      'reviewGuid': review.guid,
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };

    final Response response = await client.get(
      RemoteEndpoints.reviewReactions,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<List<dynamic>> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final List<dynamic> data = networkResponse.result as List<dynamic>;

        return data.map((e) => ReactionModel.parse(map: e)).toList();
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load business');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load business');
    }
  }

  @override
  FutureOr<void> react({
    required String token,
    required Identity review,
    required Identity listing,
    required Identity user,
    required Reaction reaction,
  }) async {
    final Map<String, String> headers = {
      HttpHeaders.authorizationHeader: token,
      'userId': user.guid,
      'reviewId': review.guid,
      'listingGuid': listing.guid,
      'ratingType': (reaction == Reaction.like).toString(),
    };

    final Response response = await client.post(
      RemoteEndpoints.reactOnReview,
      headers: headers,
    );
    /* final content = await rootBundle.loadString('api/success.json');
    await Future.delayed(Durations.extralong4);
    final response = Response(content, HttpStatus.ok); */

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<void> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        return null;
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load business');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load business');
    }
  }
}
