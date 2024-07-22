import '../../../../core/shared/shared.dart';

abstract class LoginRepository {
  FutureOr<Either<Failure, void>> login({
    required String username,
    required String password,
    required bool remember,
  });

  FutureOr<Either<Failure, void>> forgot({
    required String username,
  });

  Future<Either<Failure, void>> google();

  Future<Either<Failure, void>> facebook();

  Future<Either<Failure, void>> apple();
}
