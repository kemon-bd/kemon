import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../location/location.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

typedef LocationKey = ({
  int page,
  String location,
  CategoryEntity? category,
  SubCategoryEntity? sub,
  String? query,
  SortBy? sort,
  List<int> ratings,
});

class BusinessLocalDataSourceImpl extends BusinessLocalDataSource {
  final Map<String, BusinessEntity> _cache = {};
  final Map<_CategoryKey, BusinessesByCategoryPaginatedResponse> _category = {};
  final Map<LocationKey, BusinessesByLocationPaginatedResponse> _location = {};

  @override
  FutureOr<void> add({
    required BusinessEntity business,
  }) {
    _cache[business.urlSlug] = business;
  }

  @override
  FutureOr<void> addAll({
    required List<BusinessEntity> businesses,
  }) {
    for (final item in businesses) {
      _cache[item.urlSlug] = item;
    }
  }

  @override
  FutureOr<void> removeAll() {
    _cache.clear();
  }

  @override
  FutureOr<BusinessesByCategoryPaginatedResponse> findCategory({
    required int page,
    required String urlSlug,
    required String? query,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required CategoryEntity? category,
    required SubCategoryEntity? sub,
    required List<int> ratings,
  }) async {
    int total = 0;
    Set<BusinessEntity> businesses = {};
    Set<SubCategoryEntity> related = {};
    for (int p = 1; p <= page; p++) {
      final _CategoryKey key = _CategoryKey(
        page: p,
        urlSlug: urlSlug,
        query: query,
        sort: sort,
        division: division,
        district: district,
        thana: thana,
        category: category,
        sub: sub,
        ratings: ratings,
      );
      if (!_category.containsKey(key)) {
        throw BusinessNotFoundByCategoryInLocalCacheFailure();
      }
      final item = _category[key];
      if (item != null) {
        total = item.total;
        businesses.addAll(item.businesses);
        related.addAll(item.related);
      }
    }

    return (
      total: total,
      businesses: businesses.toList(),
      related: related.toList(),
    );
  }

  @override
  FutureOr<BusinessEntity> find({
    required String urlSlug,
  }) {
    final item = _cache[urlSlug];
    if (item == null) {
      throw BusinessNotFoundInLocalCacheFailure();
    }
    return item;
  }

  @override
  FutureOr<void> addCategory({
    required int page,
    required String urlSlug,
    required String? query,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required CategoryEntity? category,
    required SubCategoryEntity? sub,
    required List<int> ratings,
    required BusinessesByCategoryPaginatedResponse response,
  }) {
    final _CategoryKey key = _CategoryKey(
      page: page,
      urlSlug: urlSlug,
      query: query,
      sort: sort,
      division: division,
      district: district,
      thana: thana,
      category: category,
      sub: sub,
      ratings: ratings,
    );
    _category[key] = response;
    addAll(businesses: response.businesses);
  }

  @override
  FutureOr<void> addLocation({
    required int page,
    required String location,
    CategoryEntity? category,
    SubCategoryEntity? sub,
    required String? query,
    required SortBy? sort,
    required List<int> ratings,
    required BusinessesByLocationPaginatedResponse response,
  }) async {
    final key = (
      page: page,
      location: location,
      category: category,
      sub: sub,
      query: query,
      sort: sort,
      ratings: ratings,
    );
    _location[key] = response;
    addAll(businesses: response.businesses);
  }

  @override
  FutureOr<BusinessesByLocationPaginatedResponse> findLocation({
    required int page,
    required CategoryEntity? category,
    required SubCategoryEntity? subCategory,
    required String location,
    required String? query,
    required SortBy? sort,
    required List<int> ratings,
  }) async {
    int total = 0;
    Set<BusinessEntity> businesses = {};
    Set<LocationEntity> related = {};
    for (int p = 1; p <= page; p++) {
      final key = (
        page: p,
        location: location,
        category: category,
        sub: subCategory,
        query: query,
        sort: sort,
        ratings: ratings,
      );
      if (!_location.containsKey(key)) {
        throw BusinessNotFoundByCategoryInLocalCacheFailure();
      }
      final item = _location[key];
      if (item != null) {
        total = item.total;
        businesses.addAll(item.businesses);
        related.addAll(item.related);
      }
    }

    return (
      total: total,
      businesses: businesses.toList(),
      related: related.toList(),
    );
  }
}

class _CategoryKey extends Equatable {
  final int page;
  final String urlSlug;
  final String? query;
  final SortBy? sort;
  final LookupEntity? division;
  final LookupEntity? district;
  final LookupEntity? thana;
  final CategoryEntity? category;
  final SubCategoryEntity? sub;
  final List<int> ratings;

  const _CategoryKey({
    required this.page,
    required this.urlSlug,
    required this.query,
    required this.sort,
    required this.division,
    required this.district,
    required this.thana,
    required this.category,
    required this.sub,
    required this.ratings,
  });

  @override
  List<Object?> get props => [
        page,
        urlSlug,
        query,
        sort,
        division,
        district,
        thana,
        category,
        sub,
        ratings,
      ];
}
