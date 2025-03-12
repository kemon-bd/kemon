import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../review.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  final NetworkInfo network;
  final AuthenticationBloc auth;
  final ReviewRemoteDataSource remote;

  ReviewRepositoryImpl({
    required this.network,
    required this.auth,
    required this.remote,
  });

  @override
  FutureOr<Either<Failure, void>> create({
    required Identity listing,
    required double rating,
    required String title,
    required String description,
    required String date,
    required List<XFile> attachments,
  }) async {
    try {
      if (await network.online) {
        await remote.create(
          token: auth.token!,
          user: auth.identity!,
          listing: listing,
          rating: rating,
          title: title,
          description: description,
          date: date,
          attachments: attachments,
        );

        return const Right(null);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, void>> delete({
    required Identity review,
  }) async {
    try {
      if (await network.online) {
        await remote.delete(
          token: auth.token!,
          user: auth.identity!,
          review: review,
        );

        return const Right(null);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, List<UserReviewEntity>>> find({
    required Identity user,
    required bool refresh,
  }) async {
    try {
      if (await network.online) {
        final reviews = await remote.find(user: user);

        return Right(reviews);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, void>> update({
    required Identity listing,
    required ReviewCoreEntity review,
    required List<XFile> attachments,
  }) async {
    try {
      if (await network.online) {
        await remote.update(
          token: auth.token!,
          user: auth.identity!,
          review: review,
          listing: listing,
          attachments: attachments,
        );

        return const Right(null);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, void>> react({
    required Identity review,
    required Reaction reaction,
    required Identity listing,
  }) async {
    try {
      if (await network.online) {
        final reviews = await remote.react(
          token: auth.token!,
          user: auth.identity!,
          listing: listing,
          review: review,
          reaction: reaction,
        );

        return Right(reviews);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
