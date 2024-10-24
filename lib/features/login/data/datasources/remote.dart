import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
import '../../login.dart';

typedef LoginResponse = ({TokenModel token, ProfileModel profile});

abstract class LoginRemoteDataSource {
  FutureOr<LoginResponse> login({
    required String username,
    required String password,
  });

  FutureOr<void> forgot({
    required String username,
  });
}
