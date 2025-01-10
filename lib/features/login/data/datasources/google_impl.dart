import '../../../../core/shared/shared.dart';
import '../../login.dart';

class GoogleDataSourceImpl extends GoogleDataSource {
  final GoogleSignIn google;
  GoogleDataSourceImpl({required this.google});

  @override
  Future<GoogleSignInAccount> login() async {
    try {
      final result = await google.signIn();
      if (result != null) {
        return result;
      } else {
        throw RemoteFailure(message: 'Google login failed.');
      }
    } on PlatformException catch (error) {
      throw RemoteFailure(message: error.toString());
    }
  }

  @override
  Future<void> logout() async {
    await google.signOut();
    return;
  }
}
