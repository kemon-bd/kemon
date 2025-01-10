import '../../../../core/shared/shared.dart';

abstract class FacebookDataSource {
  Future<Map<String, dynamic>> login();

  Future<void> logout();
}
