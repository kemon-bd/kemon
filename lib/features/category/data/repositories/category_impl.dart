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

        await local.featured(categories: categories);
        return Right(categories);
      } else {
        return Left(NoInternetFailure());
      }
    } on SocketException {
      return Left(NoInternetFailure());
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
    } on CategoryNotFoundInLocalCacheFailure {
      final result = await remote.find(urlSlug: urlSlug);
      await local.add(category: result, urlSlug: urlSlug);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, CategoryPaginatedResponse>> all({
    required int page,
    required String? industry,
    required String? query,
  }) async {
    final key = (page: page, query: query, industry: industry);
    try {
      final result = await local.findPagination(key: key);
      return Right(result);
    } on CategoriesNotFoundInLocalCacheFailure catch (_) {
      try {
        if (await network.online) {
          final result = await remote.all(page: page, query: query, industry: industry);
          await local.cachePagination(key: key, result: result);

          final oldResult = page == 1
              ? (
                  total: 0,
                  results: <IndustryBasedCategories>[],
                )
              : await local.findPagination(key: key);
          final totalResults = oldResult.results.stitch(result.results);
          return Right((total: result.total, results: totalResults));
        } else {
          return Left(NoInternetFailure());
        }
      } on SocketException {
        return Left(NoInternetFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, CategoryPaginatedResponse>> refreshAll({
    required int page,
    required String? industry,
    required String? query,
  }) async {
    final key = (page: page, query: query, industry: industry);
    try {
      await local.removeAll();
      if (await network.online) {
        final result = await remote.all(page: page, query: query, industry: industry);
        await local.cachePagination(key: key, result: result);
        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, List<CategoryEntity>>> industry({
    required String urlSlug,
  }) async {
    try {
      final result = await local.findIndustry(industry: urlSlug);
      return Right(result);
    } on IndustryNotFoundInLocalCacheFailure {
      final result = await remote.industry(urlSlug: urlSlug);
      await local.addIndustry(categories: result, industry: urlSlug);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
