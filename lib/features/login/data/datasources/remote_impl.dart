import '../../../../core/shared/shared.dart';
import '../../../profile/profile.dart';
import '../../login.dart';

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final Client client;

  LoginRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<void> forgot({required String username}) {
    // TODO: implement forgot
    throw UnimplementedError();
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
        final RemoteResponse<Map<String, dynamic>> result = RemoteResponse.parse(response: response);

        if (result.success) {
          final TokenModel token = TokenModel.parse(map: result.result!);
          final ProfileModel profile = ProfileModel.parse(map: result.result!["userInfo"]);
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
