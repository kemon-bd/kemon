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
    final request = MultipartRequest('POST', RemoteEndpoints.newReview);
    request.headers.addAll({
      HttpHeaders.authorizationHeader: token,
      'user': user.guid,
      'listing': listing.guid,
      'star': rating.round().toString(),
      'summary': Uri.encodeComponent(title),
      'content': Uri.encodeComponent(description),
      'experience': date,
    });
    for (XFile file in attachments) {
      request.files.add(await MultipartFile.fromPath('files', file.path));
    }
    final StreamedResponse streamedResponse = await request.send();
    final response = await Response.fromStream(streamedResponse);

    if (response.statusCode == HttpStatus.noContent) {
      return;
    } else {
      throw RemoteFailure(message: response.body);
    }
  }

  @override
  FutureOr<void> delete({
    required String token,
    required Identity user,
    required Identity review,
  }) async {
    final Map<String, String> headers = {
      HttpHeaders.authorizationHeader: token,
      'user': user.guid,
      'review': review.id.toString(),
    };

    final Response response = await client.delete(
      RemoteEndpoints.deleteReview,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.noContent) {
      return;
    } else {
      throw RemoteFailure(message: response.body);
    }
  }

  @override
  FutureOr<List<UserReviewModel>> find({
    required Identity user,
  }) async {
    final Map<String, String> headers = {
      'user': user.guid,
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };

    final Response response = await client.get(
      RemoteEndpoints.specificUserReviews,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final List<Map<String, dynamic>> payload = List<Map<String, dynamic>>.from(json.decode(response.body));

      return payload.map((e) => UserReviewModel.parse(map: e)).toList();
    } else {
      throw RemoteFailure(message: response.body);
    }
  }

  @override
  FutureOr<ReviewDetailsModel> details({
    required Identity review,
    required Identity? user,
  }) async {
    final Map<String, String> headers = {
      'id': review.id.toString(),
      'user': user?.guid ?? '',
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptCharsetHeader: 'utf-8',
    };

    final Response response = await client.get(
      RemoteEndpoints.reviewDeeplink,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final Map<String, dynamic> payload = Map<String, dynamic>.from(json.decode(response.body));

      return ReviewDetailsModel.parse(map: payload);
    } else {
      throw RemoteFailure(message: response.body);
    }
  }

  @override
  FutureOr<void> update({
    required String token,
    required Identity user,
    required ReviewCoreEntity review,
    required List<String> photos,
    required List<XFile> attachments,
  }) async {
    final request = MultipartRequest('POST', RemoteEndpoints.editReview);
    request.headers.addAll({
      HttpHeaders.authorizationHeader: token,
      'id': review.identity.id.toString(),
      'user': user.guid,
      'star': review.star.round().toString(),
      'summary': Uri.encodeComponent(review.summary),
      'content': Uri.encodeComponent(review.content),
      'experience': review.experiencedAt.toIso8601String(),
      'photos': photos.join(','),
    });
    if (attachments.isNotEmpty) {
      for (XFile file in attachments) {
        request.files.add(await MultipartFile.fromPath('files', file.path));
      }
    }
    final StreamedResponse streamedResponse = await request.send();
    final response = await Response.fromStream(streamedResponse);

    if (response.statusCode == HttpStatus.noContent) {
      return;
    } else if (response.statusCode == HttpStatus.unauthorized) {
      throw UnAuthorizedFailure(message: response.body);
    } else {
      throw RemoteFailure(message: response.body);
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

  @override
  FutureOr<void> flag({
    required String token,
    required Identity review,
    required Identity user,
    required String? reason,
  }) async {
    final Map<String, String> headers = {
      HttpHeaders.authorizationHeader: token,
      'user': user.guid,
      'review': review.guid,
      'reason': reason ?? '',
    };

    final Response response = await client.post(
      RemoteEndpoints.flagReview,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.noContent) {
      return;
    } else {
      throw RemoteFailure(message: response.body);
    }
  }

  @override
  FutureOr<List<ReactionModel>> reactions({
    required Identity review,
  }) async {
    final Map<String, String> headers = {
      'review': review.guid,
    };

    final Response response = await client.get(
      RemoteEndpoints.reviewReactions,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final List<Map<String, dynamic>> payload = List<Map<String, dynamic>>.from(json.decode(response.body));
      return payload.map((e) => ReactionModel.parse(map: e)).toList();
    } else {
      throw RemoteFailure(message: response.body);
    }
  }
}
