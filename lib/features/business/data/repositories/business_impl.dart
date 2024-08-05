import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessRepositoryImpl extends BusinessRepository {
  final NetworkInfo network;
  final BusinessLocalDataSource local;
  final BusinessRemoteDataSource remote;

  BusinessRepositoryImpl({
    required this.network,
    required this.local,
    required this.remote,
  });

  @override
  FutureOr<Either<Failure, BusinessEntity>> find({
    required String urlSlug,
  }) async {
    try {
      final result = await local.find(urlSlug: urlSlug);
      return Right(result);
    } on BusinessNotFoundInLocalCacheFailure catch (_) {
      if (await network.online) {
        final result = await remote.find(urlSlug: urlSlug);
        await local.add(business: result);
        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, List<BusinessEntity>>> category({
    required String category,
  }) async {
    try {
      final result = await local.findCategory(urlSlug: category);
      return Right(result);
    } on BusinessNotFoundByCategoryInLocalCacheFailure catch (_) {
      if (await network.online) {
        final result = await remote.category(urlSlug: category);

        await local.addCategory(category: category, businesses: result);

        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
