import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class ProfileLocalDataSourceImpl extends ProfileLocalDataSource {
  final Map<String, ProfileEntity> _cache = {};

  @override
  FutureOr<void> add({
    required ProfileEntity profile,
  }) {
    _cache[profile.identity.guid] = profile;
  }

  @override
  FutureOr<void> update({
    required ProfileEntity profile,
  }) {
    _cache[profile.identity.guid] = profile;
  }

  @override
  FutureOr<void> remove({
    required Identity identity,
  }) {
    _cache.remove(identity.guid);
  }

  @override
  FutureOr<void> removeAll() {
    _cache.clear();
  }

  @override
  FutureOr<ProfileEntity> find({
    required Identity identity,
  }) {
    final item = _cache[identity.guid];
    if (item == null) {
      throw ProfileNotFoundInLocalCacheFailure();
    }
    return item;
  }
}
