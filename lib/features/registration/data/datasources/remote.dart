import '../../../../core/shared/shared.dart';

abstract class RegistrationRemoteDataSource {
  FutureOr<Identity> create({
    required String username,
    required String password,
    required String refference,
  });

  FutureOr<Identity> registerWithFacebook({
    required Map<String, dynamic> facebook,
  });

  FutureOr<Identity> registerWithGoogle({
    required GoogleSignInAccount google,
  });
  FutureOr<Identity> registerWithApple({
    required AuthorizationCredentialAppleID apple,
  });
}
