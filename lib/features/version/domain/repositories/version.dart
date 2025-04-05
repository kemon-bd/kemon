import '../../../../core/shared/shared.dart';
import '../../../whats_new/whats_new.dart';

typedef VersionUpdate = ({
  String version,
  List<WhatsNewEntity> updates,
});

abstract class VersionRepository {
  FutureOr<Either<Failure, VersionUpdate>> find();
}
