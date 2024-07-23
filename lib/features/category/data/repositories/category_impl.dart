import '../../../../core/shared/shared.dart';
import '../../category.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final NetworkInfo network;
  final CategoryLocalDataSource local;
  final CategoryRemoteDataSource remote;

  CategoryRepositoryImpl({
    required this.network,
    required this.local,
    required this.remote,
  });

  @override
  FutureOr<Either<Failure, List<CategoryEntity>>> featured() async {
    try {
      if (await network.online) {
        final categories = await remote.featured();

        await local.addAll(categories: categories);
        return Right(categories);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, CategoryEntity>> find({
    required String urlSlug,
  }) async {
    try {
      final result = await local.find(urlSlug: urlSlug);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, List<CategoryEntity>>> industry({
    required String industry,
  }) async {
    try {
      final result = await local.findByIndustry(industry: industry);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
