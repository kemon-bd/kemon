import '../../../../core/shared/shared.dart';
import '../../../industry/industry.dart';
import '../../../sub_category/sub_category.dart';
import '../../category.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final NetworkInfo network;
  final CategoryLocalDataSource local;
  final CategoryRemoteDataSource remote;
  final IndustryLocalDataSource industryCache;
  final SubCategoryLocalDataSource subCategoryCache;

  CategoryRepositoryImpl({
    required this.network,
    required this.local,
    required this.remote,
    required this.industryCache,
    required this.subCategoryCache,
  });

  @override
  FutureOr<Either<Failure, List<CategoryEntity>>> featured() async {
    try {
      if (await network.online) {
        final categories = await remote.featured();

        for (CategoryEntity category in categories) {
          local.add(urlSlug: category.urlSlug, category: category);
        }

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
      final result = local.find(urlSlug: urlSlug);
      return Right(result);
    } on CategoryNotFoundInLocalCacheFailure {
      final result = await remote.find(urlSlug: urlSlug);
      local.add(category: result, urlSlug: urlSlug);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, List<IndustryWithListingCountEntity>>> all({
    required String? query,
  }) async {
    try {
      final result = local.findAll(query: query);
      return Right(result);
    } on CategoriesNotFoundInLocalCacheFailure catch (_) {
      try {
        if (await network.online) {
          final industries = await remote.all(query: query);
          local.addAll(query: query, industries: industries);
          industryCache.addAll(query: query, industries: industries);
          for (IndustryWithListingCountEntity i in industries) {
            for (CategoryWithListingCountEntity c in i.categories) {
              subCategoryCache.addAllByCategory(category: c.urlSlug, subCategories: c.subCategories);
            }
          }
          return Right(industries);
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
  FutureOr<Either<Failure, List<IndustryWithListingCountEntity>>> refreshAll() async {
    try {
      if (await network.online) {
        final industries = await remote.all(query: null);
        local.addAll(query: null, industries: industries);
        return Right(industries);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, List<CategoryEntity>>> industry({
    required Identity identity,
  }) async {
    try {
      final result = local.findIndustry(industry: identity.guid);
      return Right(result);
    } on CategoriesNotFoundInLocalCacheFailure {
      final result = await remote.industry(identity: identity);
      local.addIndustry(categories: result, industry: identity.guid);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }

  @override
  FutureOr<Either<Failure, CategoryEntity>> deeplink({
    required String urlSlug,
  }) async {
    try {
      final result = await remote.deeplink(urlSlug: urlSlug);
      return Right(result);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
