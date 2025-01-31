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
      final result = await local.find(urlSlug: urlSlug);
      return Right(result);
    } on IndustryNotFoundInLocalCacheFailure catch (_) {
      if (await network.online) {
        final result = await remote.find();
        await local.addAll(industries: result);
        final item = await local.find(urlSlug: urlSlug);
        return Right(item);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, List<IndustryEntity>>> all() async {
    try {
      final result = await local.findAll();
      return Right(result);
    } on IndustryNotFoundInLocalCacheFailure catch (_) {
      if (await network.online) {
        final result = await remote.find();
        await local.addAll(industries: result);
        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
