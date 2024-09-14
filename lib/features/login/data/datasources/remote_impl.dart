import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
import '../../login.dart';

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final Client client;
  final FacebookAuth facebookSdk;
  final GoogleSignIn googleSdk;

  LoginRemoteDataSourceImpl({
    required this.client,
    required this.facebookSdk,
    required this.googleSdk,
  });

  @override
  Future<String> apple() async {
    final credential = await SignInWithApple.getAppleIDCredential(scopes: []);
    return credential.userIdentifier!;
  }

  @override
  Future<String> facebook() async {
    try {
      final login = await facebookSdk.login(
        permissions: [
          "email",
          "public_profile",
        ],
      );
      if (login.status != LoginStatus.success) {
        throw FacebookSignInFailure();
      }

      final data = await facebookSdk.getUserData(fields: "id");

      final String id = data["id"];

      return id;
    } catch (e) {
      rethrow;
    }
  }

  @override
  FutureOr<void> forgot({required String username}) {
    // TODO: implement forgot
    throw UnimplementedError();
  }

  @override
  Future<String> google() async {
    try {
      final account = await googleSdk.signIn();
      if (account == null) {
        throw GoogleSignInFailure();
      }
      return account.id;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  FutureOr<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    try {
      final Map<String, String> headers = {
        "username": username,
        "password": password,
      };

      final Response response = await post(
        RemoteEndpoints.login,
        headers: headers,
      );

      if (response.statusCode == HttpStatus.ok) {
        final RemoteResponse<Map<String, dynamic>> result =
            RemoteResponse.parse(response: response);

        if (result.success) {
          final TokenModel token = TokenModel.parse(map: result.result!);
          final ProfileModel profile =
              ProfileModel.parse(map: result.result!["userInfo"]);
          return (
            token: token,
            profile: profile,
          );
        } else {
          throw RemoteFailure(message: result.error!);
        }
      } else if (response.statusCode == HttpStatus.internalServerError) {
        throw RemoteFailure(message: "Internal server error.");
      } else if (response.statusCode == HttpStatus.badRequest) {
        throw RemoteFailure(message: "Bad request.");
      } else {
        throw RemoteFailure(message: "Something went wrong.");
      }
    } on SocketException {
      throw NoInternetFailure();
    } catch (error) {
      throw RemoteFailure(message: error.toString());
    }
  }
}
