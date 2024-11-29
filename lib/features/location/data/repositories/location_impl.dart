import '../../../../core/shared/shared.dart';
import '../../location.dart';

class LocationRepositoryImpl extends LocationRepository {
  final NetworkInfo network;
  final LocationLocalDataSource local;
  final LocationRemoteDataSource remote;

  LocationRepositoryImpl({
    required this.network,
    required this.local,
    required this.remote,
  });

  @override
  FutureOr<Either<Failure, List<LocationEntity>>> featured() async {
    try {
      if (await network.online) {
        final result = await remote.featured();
        await local.addAll(locations: result);
        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, LocationEntity>> find({
    required String urlSlug,
  }) async {
    try {
      final result = await local.find(urlSlug: urlSlug);
      return Right(result);
    } on CategoryNotFoundInLocalCacheFailure {
      final result = await remote.find(urlSlug: urlSlug);
      await local.add(location: result, urlSlug: urlSlug);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, LocationEntity>> refresh({
    required String urlSlug,
  }) async {
    try {
      await local.removeAll();
      final result = await remote.find(urlSlug: urlSlug);
      await local.add(location: result, urlSlug: urlSlug);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
