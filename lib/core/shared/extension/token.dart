import '../../../features/login/login.dart';

extension TokenModelExtension on TokenModel {
  Map<String, dynamic> get toMap {
    return {
      "token": token,
      "tokenExpiry": expires.toUtc().toIso8601String(),
    };
  }
}

extension TokenEntityExtension on TokenEntity {
  String get accessToken => 'Bearer $token';

  bool get expired => DateTime.now().isAfter(expires);
}
