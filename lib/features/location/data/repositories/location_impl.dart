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
        for (final location in result) {
          local.add(location: location, urlSlug: location.urlSlug);
        }

        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }


  @override
  FutureOr<Either<Failure, List<DivisionWithListingCountEntity>>> all({
    required String? query,
  }) async {
    try {
      final result = local.findAll(query: query);
      return Right(result);
    } on LocationNotFoundInLocalCacheFailure {
      if (await network.online) {
        final result = await remote.all(query: query);
        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, List<DivisionWithListingCountEntity>>> category({
    required String? query,
    required Identity industry,
    Identity? category,
    Identity? subCategory,
  }) async {
    try {
      final result = local.findByCategory(
        industry: industry,
        category: category,
        subCategory: subCategory,
      );
      return Right(
        (query ?? '').isEmpty
            ? result
            : result
                .where(
                  (d) => d.name.full.match(like: query!),
                )
                .toList(),
      );
    } on LocationNotFoundInLocalCacheFailure catch (_) {
      if (await network.online) {
        final result = await remote.category(
          industry: industry,
          category: category,
          subCategory: subCategory,
        );
        local.addByCategory(
          industry: industry,
          category: category,
          subCategory: subCategory,
          divisions: result,
        );
        return Right(
          (query ?? '').isEmpty
              ? result
              : result
                  .where(
                    (d) => d.name.full.match(like: query!),
                  )
                  .toList(),
        );
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, LocationEntity>> deeplink({
    required String urlSlug,
  }) async {
    try {
      final result = await remote.deeplink(urlSlug: urlSlug);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
