import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessLocalDataSourceImpl extends BusinessLocalDataSource {
  final Map<String, BusinessEntity> _cache = {};
  final Map<String, List<BusinessEntity>> _category = {};

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
    required String category,
    required List<BusinessEntity> businesses,
  }) {
    _category[category] = businesses;
    addAll(businesses: businesses);
  }

  @override
  FutureOr<List<BusinessEntity>> findCategory({
    required String urlSlug,
  }) {
    final businesses = _category[urlSlug];
    if (businesses == null) {
      throw BusinessNotFoundByCategoryInLocalCacheFailure();
    }
    return businesses;
  }
}
