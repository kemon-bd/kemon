import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

class SubCategoryRepositoryImpl extends SubCategoryRepository {
  final NetworkInfo network;
  final SubCategoryLocalDataSource local;
  final SubCategoryRemoteDataSource remote;

  SubCategoryRepositoryImpl({
    required this.network,
    required this.local,
    required this.remote,
  });

  @override
  FutureOr<Either<Failure, List<SubCategoryEntity>>> category({
    required String category,
  }) async {
    try {
      final subCategories = await local.findByCategory(category: category);

      return Right(subCategories);
    } on CategoryNotFoundInLocalCacheFailure {
      if (await network.online) {
        final subCategories = await remote.category(category: category);

        await local.addAllByCategory(
            category: category, subCategories: subCategories);
        return Right(subCategories);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, SubCategoryEntity>> find({
    required String urlSlug,
  }) async {
    try {
      final subCategory = await local.find(urlSlug: urlSlug);

      return Right(subCategory);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
