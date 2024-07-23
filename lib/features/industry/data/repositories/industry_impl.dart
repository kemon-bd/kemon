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
  FutureOr<Either<Failure, List<IndustryEntity>>> find() async {
    try {
      final result = await local.find();
      return Right(result);
    } on IndustryNotFoundInLocalCacheFailure catch (_) {
      if (await network.online) {
        final result = await remote.find();
        final industries = result.map((item) => item.industry).toList();
        await local.addAll(industries: industries);
        for (final item in result) {
          await category.addAllByIndustry(
            industry: item.industry.urlSlug,
            categories: item.categories,
          );
        }
        return Right(industries);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
