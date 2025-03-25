import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
import '../../login.dart';

class AppleSignInUseCase {
  final LoginRepository repository;

  AppleSignInUseCase({required this.repository});

  Future<Either<Failure, ProfileEntity>> call() async {
    return repository.appleSignIn();
  }
}
