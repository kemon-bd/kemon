import '../../../../core/shared/shared.dart';
import '../../registration.dart';

class CreateRegistrationUseCase {
  final RegistrationRepository repository;

  CreateRegistrationUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, Identity>> call({
    required String username,
    required String password,
    required String refference,
    required Name name,
    required Contact contact,
    required DateTime dob,
    required Gender gender,
  }) async {
    return await repository.create(
      username: username,
      password: password,
      refference: refference,
      name: name,
      contact: contact,
      dob: dob,
      gender: gender,
    );
  }
}
