import '../../../../core/shared/shared.dart';
import '../../business.dart' show ListingModel;

abstract class BusinessLocalDataSource {
  ListingModel find({
    required String urlSlug,
  });

  void add({
    required ListingModel listing,
    required String urlSlug,
  });
}
