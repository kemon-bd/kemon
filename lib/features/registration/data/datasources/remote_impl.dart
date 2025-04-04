import '../../../../core/shared/shared.dart';
import '../../registration.dart';

class RegistrationRemoteDataSourceImpl extends RegistrationRemoteDataSource {
  final Client client;

  RegistrationRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<Identity> create({
    required String username,
    required String password,
    required String refference,
  }) async {
    final Map<String, String> headers = {
      "userName": username,
      "password": password,
      "socialid": '',
      "refference": refference,
      "firstName": '',
      "lastName": '',
      "email": username.match(like: "@") ? username : '',
      "phone": !username.match(like: "@") ? username : '',
      "dob": '',
      "gender": '-1',
    };

    final Response response = await client.post(
      RemoteEndpoints.registration,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<String> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        return Identity.guid(guid: networkResponse.result!);
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load profile');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load profile');
    }
  }

  @override
  FutureOr<Identity> registerWithGoogle({
    required GoogleSignInAccount google,
  }) async {
    final Map<String, String> headers = {
      "userName": google.id,
      "password": google.id,
      "socialid": google.id,
      "refference": '',
      "firstName": Name.full(name: google.displayName ?? '').first,
      "lastName": Name.full(name: google.displayName ?? '').last,
      "email": google.email,
      "phone": '',
      "dob": '',
      "gender": '-1',
      "picture": google.photoUrl ?? '',
    };

    final Response response = await client.post(
      RemoteEndpoints.registration,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<String> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        return Identity.guid(guid: networkResponse.result!);
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load profile');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load profile');
    }
  }

  @override
  FutureOr<Identity> registerWithFacebook({
    required Map<String, dynamic> facebook,
  }) async {
    final String id = facebook['id'];
    final String name = facebook['name'];
    final String email = facebook['email'];
    final String picture = facebook['picture']['data']['url'];

    final Map<String, String> headers = {
      "userName": id,
      "password": id,
      "socialid": id,
      "refference": '',
      "firstName": Name.full(name: name).first,
      "lastName": Name.full(name: name).last,
      "email": email,
      "phone": '',
      "dob": '',
      "gender": '-1',
      "picture": picture,
    };

    final Response response = await client.post(
      RemoteEndpoints.registration,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<String> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        return Identity.guid(guid: networkResponse.result!);
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load profile');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load profile');
    }
  }

  @override
  FutureOr<Identity> registerWithApple({
    required AuthorizationCredentialAppleID apple,
  }) async {
    final Map<String, String> headers = {
      "userName": apple.userIdentifier ?? "",
      "password": apple.userIdentifier ?? "",
      "socialid": apple.userIdentifier ?? "",
      "refference": '',
      "firstName": apple.givenName ?? '',
      "lastName": apple.familyName ?? '',
      "email": apple.email ?? '',
      "phone": '',
      "dob": '',
      "gender": '-1',
      "picture": '',
    };

    final Response response = await client.post(
      RemoteEndpoints.registration,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<String> networkResponse = RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        return Identity.guid(guid: networkResponse.result!);
      } else {
        throw RemoteFailure(message: networkResponse.error ?? 'Failed to load profile');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load profile');
    }
  }
}
