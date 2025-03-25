import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';

abstract class LoginRepository {
  FutureOr<Either<Failure, void>> login({
    required String username,
    required String password,
    required bool remember,
  });

  FutureOr<Either<Failure, void>> forgot({
    required String username,
  });

  FutureOr<Either<Failure, ProfileEntity>> fbLogin();

  FutureOr<Either<Failure, ProfileEntity>> appleSignIn();
  
  FutureOr<Either<Failure, ProfileEntity>> googleSignIn();
}
