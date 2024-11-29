import '../../../../core/shared/shared.dart';
import '../../location.dart';

abstract class LocationLocalDataSource {
  FutureOr<void> add({
    required String urlSlug,
    required LocationEntity location,
  });

  FutureOr<void> addAll({
    required List<LocationEntity> locations,
  });

  FutureOr<void> removeAll();

  FutureOr<LocationEntity> find({
    required String urlSlug,
  });
}
