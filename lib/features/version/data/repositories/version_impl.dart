import '../../../../core/shared/shared.dart';
import '../../version.dart';

class VersionRepositoryImpl extends VersionRepository {
  final NetworkInfo network;
  final VersionRemoteDataSource remote;

  VersionRepositoryImpl({
    required this.network,
    required this.remote,
  });

  @override
  FutureOr<Either<Failure, VersionUpdate>> find() async {
    try {
      if (await network.online) {
        final result = await remote.find();

        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on VersionNotFoundInLocalCacheFailure catch (failure) {
      return Left(failure);
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
