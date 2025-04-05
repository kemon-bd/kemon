import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart' show AuthenticationBloc;
import '../../../category/category.dart' show CategoryEntity;
import '../../../industry/industry.dart' show IndustryEntity;
import '../../../lookup/lookup.dart' show LookupEntity;
import '../../../review/review.dart' show ListingReviewEntity;
import '../../../sub_category/sub_category.dart' show SubCategoryEntity, SubCategoryLocalDataSource;
import '../../business.dart';

typedef ListingEntity = (BusinessEntity, BusinessRatingInsightsEntity, List<ListingReviewEntity>, bool);

class BusinessRepositoryImpl extends BusinessRepository {
  final NetworkInfo network;
  final AuthenticationBloc auth;
  final SubCategoryLocalDataSource subCategory;
  final BusinessLocalDataSource local;
  final BusinessRemoteDataSource remote;

  BusinessRepositoryImpl({
    required this.network,
    required this.auth,
    required this.local,
    required this.remote,
    required this.subCategory,
  });

  @override
  FutureOr<Either<Failure, ListingEntity>> find({
    required String urlSlug,
    required List<int> filter,
  }) async {
    try {
      final result = local.find(urlSlug: urlSlug);
      return Right(
        filter.isEmpty
            ? result
            : (
                result.$1,
                result.$2,
                result.$3.where((r) => filter.contains(r.star)).toList(),
                result.$4,
              ),
      );
    } on BusinessNotFoundInLocalCacheFailure {
      if (await network.online) {
        final result = await remote.find(urlSlug: urlSlug, user: auth.identity);
        local.add(urlSlug: urlSlug, listing: result);
        return Right(
          filter.isEmpty
              ? result
              : (
                  result.$1,
                  result.$2,
                  result.$3.where((r) => filter.contains(r.star)).toList(),
                  result.$4,
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
  FutureOr<Either<Failure, ListingEntity>> refresh({
    required String urlSlug,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.find(urlSlug: urlSlug, user: auth.identity);
        local.add(urlSlug: urlSlug, listing: result);
        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, List<BusinessLiteEntity>>> category({
    required Identity industry,
    required Identity? category,
    required Identity? subCategory,
    required String? division,
    required String? district,
    required String? thana,
    required String? query,
    required SortBy? sort,
    required RatingRange ratings,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.category(
          industry: industry,
          category: category,
          subCategory: subCategory,
          division: division,
          district: district,
          thana: thana,
          query: query,
          sort: sort,
          ratings: ratings,
        );
        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, List<BusinessLiteEntity>>> refreshCategory({
    required Identity industry,
    required Identity? category,
    required Identity? subCategory,
    required String? division,
    required String? district,
    required String? thana,
    required String? query,
    required SortBy? sort,
    required RatingRange ratings,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.category(
          industry: industry,
          category: category,
          subCategory: subCategory,
          division: division,
          district: district,
          thana: thana,
          query: query,
          sort: sort,
          ratings: ratings,
        );
        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, List<BusinessLiteEntity>>> location({
    required String division,
    String? district,
    String? thana,
    required String? query,
    required Identity? industry,
    required Identity? category,
    required Identity? subCategory,
    required SortBy? sort,
    required RatingRange ratings,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.location(
          division: division,
          district: district,
          thana: thana,
          query: query,
          industry: industry,
          category: category,
          subCategory: subCategory,
          sort: sort,
          ratings: ratings,
        );
        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, List<BusinessLiteEntity>>> refreshLocation({
    required String division,
    String? district,
    String? thana,
    required String? query,
    required Identity? industry,
    required Identity? category,
    required Identity? subCategory,
    required SortBy? sort,
    required RatingRange ratings,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.location(
          division: division,
          district: district,
          thana: thana,
          query: query,
          industry: industry,
          category: category,
          subCategory: subCategory,
          sort: sort,
          ratings: ratings,
        );

        return Right(result);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, void>> validateUrlSlug({
    required String urlSlug,
  }) async {
    try {
      // await local.removeAll();
      if (await network.online) {
        await remote.validateUrlSlug(urlSlug: urlSlug);
        return Right(null);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  FutureOr<Either<Failure, void>> publish({
    required String name,
    required String urlSlug,
    required String about,
    required XFile? logo,
    required ListingType type,
    required String phone,
    required String email,
    required String website,
    required String social,
    required IndustryEntity industry,
    required CategoryEntity? category,
    required SubCategoryEntity? subCategory,
    required String address,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
  }) async {
    try {
      await remote.publish(
        token: auth.token!,
        user: auth.identity!,
        name: name,
        urlSlug: urlSlug,
        about: about,
        logo: logo,
        type: type,
        phone: phone,
        email: email,
        website: website,
        social: social,
        industry: industry,
        category: category,
        subCategory: subCategory,
        address: address,
        division: division,
        district: district,
        thana: thana,
      );

      return Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    }
  }
}
