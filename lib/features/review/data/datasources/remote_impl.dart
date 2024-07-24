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
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  FutureOr<void> delete({
    required String token,
    required Identity user,
    required Identity review,
  }) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<RatingModel> rating({
    required String token,
    required String urlSlug,
  }) async {
    // TODO: implement details
    throw UnimplementedError();
  }

  @override
  FutureOr<List<ReviewModel>> find({
    required Identity user,
  }) async {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  FutureOr<void> update({
    required String token,
    required Identity user,
    required ReviewEntity review,
  }) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}
