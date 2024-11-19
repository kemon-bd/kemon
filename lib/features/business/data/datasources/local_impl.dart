import '../../../../core/shared/shared.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';
import '../../business.dart';

typedef CategoryKey = ({
  int page,
  String category,
  SortBy? sort,
  LookupEntity? division,
  LookupEntity? district,
  LookupEntity? thana,
  SubCategoryEntity? sub,
  List<int> ratings,
});

class BusinessLocalDataSourceImpl extends BusinessLocalDataSource {
  final Map<String, BusinessEntity> _cache = {};
  final Map<CategoryKey, BusinessesByCategoryPaginatedResponse> _category = {};

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
    required String category,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required SubCategoryEntity? sub,
    required List<int> ratings,
  }) async {
    final key = (
      page: page,
      category: category,
      sort: sort,
      division: division,
      district: district,
      thana: thana,
      sub: sub,
      ratings: ratings,
    );
    if (!_category.containsKey(key)) {
      throw BusinessNotFoundByCategoryInLocalCacheFailure();
    }
    int total = 0;
    List<BusinessEntity> businesses = [];
    List<SubCategoryEntity> related = [];
    for (int p = 1; p <= page; p++) {
      final item = _category[key];
      if (item != null) {
        total = item.total;
        businesses.addAll(item.businesses);
        related.addAll(item.related);
      }
    }

    return (
      total: total,
      businesses: businesses,
      related: related,
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
    required String category,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required SubCategoryEntity? sub,
    required List<int> ratings,
    required BusinessesByCategoryPaginatedResponse response,
  }) {
    final key = (
      page: page,
      category: category,
      sort: sort,
      division: division,
      district: district,
      thana: thana,
      sub: sub,
      ratings: ratings,
    );
    _category[key] = response;
    addAll(businesses: response.businesses);
  }

  @override
  FutureOr<void> removeCategory({
    required int page,
    required String category,
    required SortBy? sort,
    required LookupEntity? division,
    required LookupEntity? district,
    required LookupEntity? thana,
    required SubCategoryEntity? sub,
    required List<int> ratings,
  }) {
    final key = (
      page: page,
      category: category,
      sort: sort,
      division: division,
      district: district,
      thana: thana,
      sub: sub,
      ratings: ratings,
    );

    _category.remove(key);
  }
}
