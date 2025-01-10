import '../../../../core/shared/shared.dart';
import '../../login.dart';

class FacebookDataSourceImpl extends FacebookDataSource {
  final FacebookAuth facebook;
  FacebookDataSourceImpl({required this.facebook});

  @override
  Future<Map<String, dynamic>> login() async {
    final result = await facebook.login(
      loginBehavior: LoginBehavior.dialogOnly,
    );
    if (result.status == LoginStatus.success) {
      final profile = await facebook.getUserData();
      return profile;
    } else {
      throw RemoteFailure(message: result.message ?? 'Facebook login failed.');
    }
  }

  @override
  Future<void> logout() async {
    await facebook.logOut();
    return;
  }
}
