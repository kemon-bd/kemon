import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../industry.dart';

class IndustryRepositoryImpl extends IndustryRepository {
  final NetworkInfo network;
  final CategoryLocalDataSource category;
  final IndustryLocalDataSource local;
  final IndustryRemoteDataSource remote;

  IndustryRepositoryImpl({
    required this.network,
    required this.category,
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
        final industries = result.map((item) => item.industry).toList();
        await local.addAll(industries: industries);
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
      if (await network.online) {
        final result = await remote.find();
        for (var row in result) {
          await category.cachePagination(
            key: (
              page: 1,
              query: null,
              industry: row.industry.urlSlug,
            ),
            result: (
              results: [(industry: row.industry, categories: row.categories)],
              total: 0,
            ),
          );
        }
        final industries = result.map((item) => item.industry).toList();
        final Set<IndustryEntity> industriesSet = {};
        industriesSet.addAll(industries);
        await local.addAll(industries: industriesSet.toList());
        return Right(industriesSet.toList());
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
