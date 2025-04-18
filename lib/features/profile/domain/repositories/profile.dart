import '../../../../core/shared/shared.dart';
import '../../profile.dart';

abstract class ProfileRepository {
  FutureOr<Either<Failure, CheckResponse>> check({
    required String username,
  });

  FutureOr<Either<Failure, void>> delete({
    required Identity identity,
  });

  FutureOr<Either<Failure, ProfileEntity>> find({
    required Identity identity,
  });

  FutureOr<Either<Failure, ProfileEntity>> refresh({
    required Identity identity,
  });

  FutureOr<Either<Failure, void>> update({
    required ProfileEntity profile,
    XFile? avatar,
  });

  FutureOr<Either<Failure, String>> generateOtpForAccountDeactivation();

  FutureOr<Either<Failure, void>> deactivateAccount({
    required String otp,
  });

  FutureOr<Either<Failure, String>> requestOtpForPasswordChange({
    required String username,
    required bool verificationOnly,
  });

  FutureOr<Either<Failure, void>> resetPassword({
    required String username,
    required String password,
  });
  
  FutureOr<Either<Failure, void>> block({
    required Identity victim,
    required String? reason,
  });

  FutureOr<Either<Failure, void>> unblock({
    required Identity victim,
  });

  FutureOr<Either<Failure, List<UserPreviewEntity>>> blockList();
}
