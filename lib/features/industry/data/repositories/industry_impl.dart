import '../../../../core/shared/shared.dart';
import '../../industry.dart';

class IndustryRepositoryImpl extends IndustryRepository {
  final NetworkInfo network;
  final IndustryLocalDataSource local;
  final IndustryRemoteDataSource remote;

  IndustryRepositoryImpl({
    required this.network,
    required this.local,
    required this.remote,
  });

  @override
  FutureOr<Either<Failure, IndustryEntity>> find({
    required String urlSlug,
  }) async {
    try {
      final result = local.find(urlSlug: urlSlug);
      return Right(result);
    } on IndustryNotFoundInLocalCacheFailure catch (_) {
      if (await network.online) {
        final result = await remote.find();
        local.addAll(query: null, industries: result);
        final item = local.find(urlSlug: urlSlug);
        return Right(item);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, List<IndustryEntity>>> all({
    required String? query,
  }) async {
    try {
      final result = local.findAll(query: query);
      return Right(result);
    } on IndustryNotFoundInLocalCacheFailure catch (_) {
      if (await network.online) {
        final result = await remote.find();
        local.addAll(query: query, industries: result);
        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, List<IndustryWithListingCountModel>>> location({
    required String? query,
    required String division,
    String? district,
    String? thana,
  }) async {
    try {
      final result = local.findByLocation(division: division, district: district, thana: thana);
      return Right(
        (query ?? '').isEmpty
            ? result
            : result
                .where(
                  (i) => i.name.full.match(like: query!),
                )
                .toList(),
      );
    } on IndustryNotFoundInLocalCacheFailure catch (_) {
      if (await network.online) {
        final result = await remote.location(division: division, district: district, thana: thana);
        local.addByLocation(industries: result, division: division, district: district, thana: thana);
        return Right(
          (query ?? '').isEmpty
              ? result
              : result
                  .where(
                    (i) => i.name.full.match(like: query!),
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
}
