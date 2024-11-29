import '../../../../core/shared/shared.dart';
import '../../profile.dart';

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final Client client;

  ProfileRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<CheckResponse> check({
    required String username,
  }) async {
    try {
      final Map<String, String> headers = {
        "username": username,
      };

      final Response response = await post(
        RemoteEndpoints.login,
        headers: headers,
      );

      if (response.statusCode == HttpStatus.ok) {
        final RemoteResponse<Map<String, dynamic>> result =
            RemoteResponse.parse(response: response);

        if (result.success) {
          if (result.result!.containsKey('otp')) {
            return Left(result.result!["otp"]);
          } else {
            final ProfileModel profile =
                ProfileModel.parse(map: result.result!);
            return Right(profile);
          }
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

  @override
  FutureOr<void> delete({
    required String token,
    required Identity identity,
  }) async {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  FutureOr<ProfileModel> find({
    required Identity identity,
  }) async {
    final Map<String, String> headers = {
      "userId": identity.guid,
    };

    final Response response = await client.get(
      RemoteEndpoints.profile,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<dynamic> networkResponse =
          RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        final Map<String, dynamic> data =
            networkResponse.result as Map<String, dynamic>;

        return ProfileModel.parse(map: data['profile']);
      } else {
        throw RemoteFailure(
            message: networkResponse.error ?? 'Failed to load profile');
      }
    } else {
      throw RemoteFailure(
          message: response.reasonPhrase ?? 'Failed to load profile');
    }
  }

  @override
  FutureOr<void> update({
    required String token,
    required ProfileEntity profile,
    XFile? avatar,
  }) async {
    final request = MultipartRequest('POST', RemoteEndpoints.updateProfile);
    request.headers.addAll({
      'authorization': token,
      'userId': profile.identity.guid,
      'firstName': profile.name.first,
      'lastName': profile.name.last,
      'email': profile.phone?.number ?? '',
      'phone': profile.email?.address ?? '',
      'dob': profile.dob?.toIso8601String() ?? '',
      'gender': profile.gender?.index.toString() ?? '-1',
      'isupload': avatar != null ? 'true' : 'false',
    });
    if (avatar != null) {
      request.files.add(await MultipartFile.fromPath('File', avatar.path));
    }
    final StreamedResponse streamedResponse = await request.send();
    final response = await Response.fromStream(streamedResponse);

    if (response.statusCode == HttpStatus.ok) {
      final networkResponse = RemoteResponse.parse(response: response);
      if (networkResponse.success) {
        return;
      } else {
        throw RemoteFailure(
            message: networkResponse.error ??
                response.reasonPhrase ??
                "Someting went wrong.");
      }
    } else {
      throw RemoteFailure(
          message: response.reasonPhrase ?? 'Failed to add review');
    }
  }

  @override
  FutureOr<void> deactivateAccount({
    required String token,
    required String username,
    required String otp,
  }) async {
    try {
      final Map<String, String> headers = {
        "username": username,
        "code": otp,
      };

      final Response response = await post(
        RemoteEndpoints.deactivateAccount,
        headers: headers,
      );

      if (response.statusCode == HttpStatus.ok) {
        final RemoteResponse<String> result =
            RemoteResponse.parse(response: response);

        if (result.success) {
          return;
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

  @override
  FutureOr<String> generateOtpForAccountDeactivation({
    required String token,
    required String username,
  }) async {
    try {
      final Map<String, String> headers = {
        "username": username,
      };

      final Response response = await post(
        RemoteEndpoints.deactivateAccount,
        headers: headers,
      );

      if (response.statusCode == HttpStatus.ok) {
        final RemoteResponse<String> result =
            RemoteResponse.parse(response: response);

        if (result.success) {
          return result.result!;
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

  @override
  FutureOr<String> requestOtpForPasswordChange({
    required String username,
  }) async {
    try {
      final Map<String, String> headers = {
        "username": username,
      };

      final Response response = await post(
        RemoteEndpoints.changePassword,
        headers: headers,
      );

      if (response.statusCode == HttpStatus.ok) {
        final RemoteResponse<String> result =
            RemoteResponse.parse(response: response);

        if (result.success) {
          return result.result!;
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

  @override
  FutureOr<void> resetPassword({
    required String username,
    required String password,
  }) async {
    try {
      final Map<String, String> headers = {
        "username": username,
        "newpassword": password,
      };

      final Response response = await post(
        RemoteEndpoints.changePassword,
        headers: headers,
      );

      if (response.statusCode == HttpStatus.ok) {
        final RemoteResponse<String> result =
            RemoteResponse.parse(response: response);

        if (result.success) {
          return;
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
