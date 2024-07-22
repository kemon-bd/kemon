import '../../../../core/shared/shared.dart';
import '../../home.dart';

typedef HomeEntityPaginatedResponse = ({
  List<HomeEntity> items,
  int total,
});

abstract class HomeRepository {
  FutureOr<Either<Failure, void>> create({
    required HomeEntity home,
  });

  FutureOr<Either<Failure, void>> delete({
    required int id,
  });

  FutureOr<Either<Failure, HomeEntity>> find({
    required int id,
  });

  FutureOr<Either<Failure, List<HomeEntity>>> read();

  FutureOr<Either<Failure, List<HomeEntity>>> refresh();

  FutureOr<Either<Failure, List<HomeEntity>>> search({
    required String query,
  });

  FutureOr<Either<Failure, void>> update({
    required HomeEntity home,
  });
}
