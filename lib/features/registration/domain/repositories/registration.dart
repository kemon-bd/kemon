import '../../../../core/shared/shared.dart';

abstract class RegistrationRepository {
  FutureOr<Either<Failure, Identity>> create({
    required String username,
    required String password,
    required String refference,
  });

  FutureOr<Either<Failure, String>> otp({
    required String username,
  });
}
