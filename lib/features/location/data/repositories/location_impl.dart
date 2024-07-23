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
}
