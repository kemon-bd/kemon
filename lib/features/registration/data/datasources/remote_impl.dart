import '../../../../core/shared/shared.dart';
import '../../registration.dart';

class RegistrationRemoteDataSourceImpl extends RegistrationRemoteDataSource {
  final Client client;

  RegistrationRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<void> create({
    required String username,
    required String password,
    required String refference,
    required Name name,
    required Contact contact,
    required DateTime dob,
    required Gender gender,
  }) async {
    final Map<String, String> headers = {
      "userName": username,
      "password": password,
      "socialid": '',
      "refference": refference,
      "firstName": name.first,
      "lastName": name.last,
      "email": contact.email ?? '',
      "phone": contact.phone ?? '',
      "dob": dob.MMddyyyy,
      "gender": gender.index.toString(),
    };

    final Response response = await client.post(
      RemoteEndpoints.registration,
      headers: headers,
    );

    if (response.statusCode == HttpStatus.ok) {
      final RemoteResponse<dynamic> networkReponse = RemoteResponse.parse(response: response);

      if (networkReponse.success) {
        return;
      } else {
        throw RemoteFailure(message: networkReponse.error ?? 'Failed to load profile');
      }
    } else {
      throw RemoteFailure(message: response.reasonPhrase ?? 'Failed to load profile');
    }
  }
}
