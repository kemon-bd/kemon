import '../../../../core/shared/shared.dart';
import '../../../lookup/lookup.dart';
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
  FutureOr<Either<Failure, BusinessEntity>> refresh({
    required String urlSlug,
  }) async {
    try {
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
    required String? query,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required SubCategoryEntity? sub,
    required List<int> ratings,
  }) async {
    try {
      final result = await local.findCategory(
        category: category,
        page: page,
        query: query,
        sort: sort,
        division: division,
        district: district,
        thana: thana,
        sub: sub,
        ratings: ratings,
      );
      return Right(result);
    } on BusinessNotFoundByCategoryInLocalCacheFailure catch (_) {
      if (await network.online) {
        final result = await remote.category(
          page: page,
          urlSlug: category,
          query: query,
          sort: sort,
          division: division,
          district: district,
          thana: thana,
          subCategory: sub,
          ratings: ratings,
        );

        await local.addCategory(
          category: category,
          page: page,
          query: query,
          sort: sort,
          division: division,
          district: district,
          thana: thana,
          sub: sub,
          ratings: ratings,
          response: result,
        );
        await subCategory.addAll(subCategories: result.related);

        final oldBuinesses = page == 1
            ? (
                total: 0,
                businesses: [],
                related: [],
              )
            : await local.findCategory(
                category: category,
                query: query,
                sort: sort,
                division: division,
                district: district,
                thana: thana,
                sub: sub,
                ratings: ratings,
                page: page - 1,
              );

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

  @override
  FutureOr<Either<Failure, BusinessesByCategoryPaginatedResponse>> refreshCategory({
    required int page,
    required String category,
    required String? query,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required SubCategoryEntity? sub,
    required List<int> ratings,
  }) async {
    try {
      await local.removeAll();
      if (await network.online) {
        final result = await remote.category(
          page: page,
          urlSlug: category,
          query: query,
          sort: sort,
          division: division,
          district: district,
          thana: thana,
          subCategory: sub,
          ratings: ratings,
        );

        await local.addCategory(
          category: category,
          page: page,
          query: query,
          sort: sort,
          division: division,
          district: district,
          thana: thana,
          sub: sub,
          ratings: ratings,
          response: result,
        );
        await subCategory.addAll(subCategories: result.related);

        final oldBuinesses = page == 1
            ? (
                total: 0,
                businesses: [],
                related: [],
              )
            : await local.findCategory(
                category: category,
                page: page - 1,
                query: query,
                sort: sort,
                division: division,
                district: district,
                thana: thana,
                sub: sub,
                ratings: ratings,
              );

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
