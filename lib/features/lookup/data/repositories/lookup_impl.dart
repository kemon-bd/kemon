import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

class LookupRepositoryImpl extends LookupRepository {
  final NetworkInfo network;
  final LookupLocalDataSource local;
  final LookupRemoteDataSource remote;

  LookupRepositoryImpl({
    required this.network,
    required this.local,
    required this.remote,
  });

  @override
  FutureOr<Either<Failure, List<LookupEntity>>> find({
    required LookupKey key,
  }) async {
    try {
      final result = await local.find(key: key);
      return Right(result);
    } on LookupNotFoundInLocalCacheFailure catch (_) {
      if (await network.online) {
        final result = await remote.find(key: key);
        await local.cache(key: key, items: result);
        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
