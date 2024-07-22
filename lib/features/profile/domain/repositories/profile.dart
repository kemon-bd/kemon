import '../../../../core/shared/shared.dart';
import '../../profile.dart';

abstract class ProfileRepository {
  FutureOr<Either<Failure, CheckResponse>> check({
    required String username,
  });

  FutureOr<Either<Failure, void>> delete({
    required Identity identity,
  });

  FutureOr<Either<Failure, ProfileEntity>> find({
    required Identity identity,
  });

  FutureOr<Either<Failure, void>> update({
    required ProfileEntity profile,
  });
}
