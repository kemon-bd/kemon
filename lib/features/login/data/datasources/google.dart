
import '../../../../core/shared/shared.dart';

abstract class GoogleDataSource {
  Future<GoogleSignInAccount> login();

  Future<void> logout();
}
