import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessLocalDataSourceImpl extends BusinessLocalDataSource {
  final Map<String, BusinessEntity> _cache = {};
  final Map<(String, int), BusinessesByCategoryPaginatedResponse> _category = {};

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
    required BusinessesByCategoryPaginatedResponse response,
  }) {
    _category[(category, page)] = response;
    addAll(businesses: response.businesses);
  }

  @override
  FutureOr<BusinessesByCategoryPaginatedResponse> findCategory({
    required int page,
    required String urlSlug,
  }) async {
    if (!_category.containsKey((urlSlug, page))) {
      throw BusinessNotFoundByCategoryInLocalCacheFailure();
    }
    int total = 0;
    List<BusinessEntity> businesses = [];
    for (int p = 1; p <= page; p++) {
      final item = _category[(urlSlug, p)];
      if (item != null) {
        total = item.total;
        businesses.addAll(item.businesses);
      }
    }

    return (total: total, businesses: businesses);
  }
}
