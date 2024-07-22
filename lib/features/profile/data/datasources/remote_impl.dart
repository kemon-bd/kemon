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
  }) {
    // TODO: implement check
    throw UnimplementedError();
  }

  @override
  FutureOr<void> delete({
    required String token,
    required Identity identity,
  }) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  FutureOr<ProfileModel> find({
    required Identity identity,
  }) {
    // TODO: implement find
    throw UnimplementedError();
  }

  @override
  FutureOr<void> update({
    required String token,
    required ProfileEntity profile,
  }) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
