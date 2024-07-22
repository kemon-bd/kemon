import '../../../../core/shared/shared.dart';
import '../../login.dart';

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final Client client;

  LoginRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<String> apple() {
    // TODO: implement apple
    throw UnimplementedError();
  }

  @override
  Future<String> facebook() {
    // TODO: implement facebook
    throw UnimplementedError();
  }

  @override
  FutureOr<void> forgot({required String username}) {
    // TODO: implement forgot
    throw UnimplementedError();
  }

  @override
  Future<String> google() {
    // TODO: implement google
    throw UnimplementedError();
  }

  @override
  FutureOr<LoginResponse> login({required String username, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }
}
