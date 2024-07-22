import '../../../../core/shared/shared.dart';
import '../../login.dart';

class TokenModel extends TokenEntity {
  const TokenModel({
    required super.token,
    required super.expires,
  });

  factory TokenModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      assert(
        map.containsKey("token"),
        "TokenModel.parse: token not found",
      );
      assert(
        map["token"] is String,
        "TokenModel.parse: token is not a String",
      );
      final token = map["token"] as String;

      assert(
        map.containsKey("tokenExpiry"),
        "TokenModel.parse: tokenExpiry not found",
      );
      assert(
        map["tokenExpiry"] is String,
        "TokenModel.parse: tokenExpiry is not an int",
      );
      final expires = DateTime.parse(map["tokenExpiry"]);

      return TokenModel(
        token: token,
        expires: expires.add(DateTime.now().timeZoneOffset),
      );
    } catch (e, stackTrace) {
      throw TokenModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }

  @override
  List<Object?> get props => [
        token,
        expires,
      ];
}
