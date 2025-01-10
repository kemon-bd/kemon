import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
import '../../login.dart';

class GoogleSignInUseCase {
  final LoginRepository repository;

  GoogleSignInUseCase({required this.repository});

  Future<Either<Failure, ProfileEntity>> call() async {
    return repository.googleSignIn();
  }
}
