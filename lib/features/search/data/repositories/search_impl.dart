import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../industry/industry.dart';
import '../../../location/location.dart';
import '../../../sub_category/sub_category.dart';
import '../../search.dart';

class SearchRepositoryImpl extends SearchRepository {
  final NetworkInfo network;
  final LocationLocalDataSource location;
  final IndustryLocalDataSource industry;
  final CategoryLocalDataSource category;
  final SubCategoryLocalDataSource subCategory;
  final SearchLocalDataSource local;
  final SearchRemoteDataSource remote;

  SearchRepositoryImpl({
    required this.network,
    required this.location,
    required this.industry,
    required this.category,
    required this.subCategory,
    required this.local,
    required this.remote,
  });

  @override
  Future<Either<Failure, SearchResults>> result({
    required String query,
    required FilterOptions filter,
  }) async {
    try {
      final result = await local.findResult(query: query, filter: filter);
      return Right(result);
    } on SearchResultsNotFoundInLocalCacheFailure catch (_) {
      if (await network.online) {
        final results = await remote.result(query: query, filter: filter);
        await local.addResult(query: query, filter: filter, results: results);

        for (LocationEntity l in results.locations) {
          location.add(urlSlug: l.urlSlug, location: l);
        }
        await subCategory.addAll(subCategories: results.subCategories);
        return Right(results);
      } else {
        return Left(NoInternetFailure());
      }
    } on Failure catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either<Failure, List<SearchSuggestionEntity>>> suggestion({
    required String query,
  }) async {
    try {
      /* final result = await local.findSuggestion(query: query);
      return Right(result);
    } on SearchSuggestionsNotFoundInLocalCacheFailure catch (_) {
      try { */
      if (await network.online) {
        final suggestions = await remote.suggestion(query: query);
        for (var s in suggestions) {
          if (s is IndustryEntity) {
            industry.add(industry: s as IndustryEntity);
          } else if (s is CategoryEntity) {
            category.add(urlSlug: s.urlSlug, category: s as CategoryEntity);
          } else if (s is SubCategoryEntity) {
            subCategory.add(subCategory: s as SubCategoryEntity);
          }
        }

        return Right(suggestions.arrange(query: query));
      } else {
        return Left(NoInternetFailure());
      }
      /* } on Failure catch (e) {
        return Left(e);
      } */
    } on Failure catch (e) {
      return Left(e);
    }
  }
}
