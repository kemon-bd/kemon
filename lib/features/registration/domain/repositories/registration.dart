import '../../../../core/shared/shared.dart';

abstract class RegistrationRepository {
  FutureOr<Either<Failure, void>> create({
    required String username,
    required String password,
    required String refference,
    required Name name,
    required Contact contact,
    required DateTime dob,
    required Gender gender,
  });

  FutureOr<Either<Failure, String>> otp({
    required String username,
  });
}
