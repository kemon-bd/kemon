import '../../../../core/shared/shared.dart';
import '../../profile.dart';

typedef CheckResponse = Either<String, ProfileModel>;

abstract class ProfileRemoteDataSource {
  FutureOr<CheckResponse> check({
    required String username,
  });

  FutureOr<void> delete({
    required String token,
    required Identity identity,
  });

  FutureOr<ProfileModel> find({
    required Identity identity,
  });

  FutureOr<void> update({
    required String token,
    required ProfileEntity profile,
  });
}
