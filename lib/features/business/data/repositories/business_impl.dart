import 'package:kemon/features/industry/domain/entities/industry.dart';

import '../../../../core/shared/shared.dart';
import '../../../authentication/authentication.dart';
import '../../../category/category.dart';
import '../../../lookup/lookup.dart';
import '../../../review/review.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

typedef ListingEntity = (BusinessEntity, List<ListingReviewEntity>);

class BusinessRepositoryImpl extends BusinessRepository {
  final NetworkInfo network;
  final AuthenticationBloc auth;
  final SubCategoryLocalDataSource subCategory;
  final BusinessRemoteDataSource remote;

  BusinessRepositoryImpl({
    required this.network,
    required this.auth,
    // required this.local,
    required this.remote,
    required this.subCategory,
  });

  @override
  FutureOr<Either<Failure, ListingEntity>> find({
    required String urlSlug,
  }) async {
    try {
      if (await network.online) {
        final result = await remote.find(urlSlug: urlSlug, user: auth.identity);
        return Right(result);
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
