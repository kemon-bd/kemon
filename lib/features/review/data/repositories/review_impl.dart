import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../review.dart';

class ReviewRepositoryImpl extends ReviewRepository {
  final NetworkInfo network;
  final AuthenticationBloc auth;
  final ReviewLocalDataSource local;
  final ReviewRemoteDataSource remote;

  ReviewRepositoryImpl({
    required this.network,
    required this.auth,
    required this.local,
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

        await local.remove(key: auth.guid!, review: review);

        return const Right(null);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  Future<Either<Failure, RatingEntity>> rating({
    required String urlSlug,
  }) async {
    try {
      final rating = await local.findRating(urlSlug: urlSlug);
      return Right(rating);
    } on RatingNotFoundInLocalCacheFailure {
      if (await network.online) {
        final rating = await remote.rating(urlSlug: urlSlug);

        await local.addRating(urlSlug: urlSlug, rating: rating.rating);
        await local.addAll(key: urlSlug, reviews: rating.reviews);
        return Right(rating.rating);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, List<ReviewEntity>>> find({
    required Identity user,
  }) async {
    try {
      final reviews = await local.find(key: user.guid);
      return Right(reviews);
    } on ReviewNotFoundInLocalCacheFailure {
      if (await network.online) {
        final reviews = await remote.find(user: user);

        await local.addAll(key: user.guid, reviews: reviews);
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
    required ReviewEntity review,
  }) async {
    try {
      if (await network.online) {
        await remote.update(token: auth.token!, user: auth.identity!, review: review);
        await local.update(key: auth.guid!, review: review);

        return const Right(null);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, List<ReviewEntity>>> reviews({
    required String urlSlug,
  }) async {
    try {
      final reviews = await local.find(key: urlSlug);
      return Right(reviews);
    } on ReviewNotFoundInLocalCacheFailure {
      if (await network.online) {
        final reviews = await remote.rating(
          urlSlug: urlSlug,
        );

        await local.addRating(urlSlug: urlSlug, rating: reviews.rating);
        await local.addAll(key: urlSlug, reviews: reviews.reviews);
        return Right(reviews.reviews);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, List<ReviewEntity>>> recent() async {
    try {
      if (await network.online) {
        final reviews = await remote.recent();

        return Right(reviews);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
