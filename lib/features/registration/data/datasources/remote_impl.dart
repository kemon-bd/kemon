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
      "email": '',
      "phone": '',
      "dob": '',
      "gender": '-1',
    };

    final Response response = await client.post(
      RemoteEndpoints.registration,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<String> networkResponse =
          RemoteResponse.parse(response: response);

      if (networkResponse.success) {
        return Identity.guid(guid: networkResponse.result!);
      } else {
        throw RemoteFailure(
            message: networkResponse.error ?? 'Failed to load profile');
      }
    } else {
      throw RemoteFailure(
          message: response.reasonPhrase ?? 'Failed to load profile');
    }
  }
}
