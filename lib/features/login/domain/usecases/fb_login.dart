import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
import '../../login.dart';

class FacebookLoginUseCase {
  final LoginRepository repository;

  FacebookLoginUseCase({required this.repository});

  Future<Either<Failure, ProfileEntity>> call() async {
    return repository.fbLogin();
  }
}
