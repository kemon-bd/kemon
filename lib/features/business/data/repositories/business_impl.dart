import '../../../../core/shared/shared.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

class BusinessRepositoryImpl extends BusinessRepository {
  final NetworkInfo network;
  final BusinessLocalDataSource local;
  final SubCategoryLocalDataSource subCategory;
  final BusinessRemoteDataSource remote;

  BusinessRepositoryImpl({
    required this.network,
    required this.local,
    required this.remote,
    required this.subCategory,
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
  FutureOr<Either<Failure, BusinessesByCategoryPaginatedResponse>> category({
    required int page,
    required String category,
  }) async {
    try {
      final result = await local.findCategory(urlSlug: category, page: page);
      return Right(result);
    } on BusinessNotFoundByCategoryInLocalCacheFailure catch (_) {
      if (await network.online) {
        final result = await remote.category(
          page: page,
          urlSlug: category,
        );

        await local.addCategory(category: category, response: result, page: page);
        await subCategory.addAll(subCategories: result.related);

        final oldBuinesses = page == 1
            ? (
                total: 0,
                businesses: [],
                related: [],
              )
            : await local.findCategory(page: page - 1, urlSlug: category);

        return Right(
          (
            total: result.total,
            businesses: [...oldBuinesses.businesses, ...result.businesses],
            related: result.related,
          ),
        );
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
