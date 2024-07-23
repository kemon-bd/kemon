import '../../../../core/shared/shared.dart';
import '../../location.dart';

abstract class LocationRemoteDataSource {
  FutureOr<List<LocationModel>> featured();
}
