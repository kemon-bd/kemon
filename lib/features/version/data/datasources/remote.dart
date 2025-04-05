import '../../../../core/shared/shared.dart';
import '../../version.dart';

abstract class VersionRemoteDataSource {
  FutureOr<VersionUpdate> find();
}
