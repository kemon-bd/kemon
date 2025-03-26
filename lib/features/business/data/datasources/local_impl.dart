import '../../../../core/shared/shared.dart';
import '../../business.dart' show ListingModel, BusinessLocalDataSource;

class BusinessLocalDataSourceImpl extends BusinessLocalDataSource {
  final Map<String, ListingModel> cache = {};

  @override
  void add({
    required ListingModel listing,
    required String urlSlug,
  }) {
    cache[urlSlug] = listing;
  }

  @override
  ListingModel find({
    required String urlSlug,
  }) {
    final listing = cache[urlSlug];
    if (listing == null) {
      throw BusinessNotFoundInLocalCacheFailure();
    }
    return listing;
  }
}
