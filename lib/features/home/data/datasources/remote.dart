import '../../../../core/shared/shared.dart';
import '../../home.dart';

abstract class HomeRemoteDataSource {
  FutureOr<void> create({
    required HomeEntity home,
  });

  FutureOr<void> delete({
    required int id,
  });

  FutureOr<HomeModel> find({
    required int id,
  });

  FutureOr<List<HomeModel>> read();

  FutureOr<List<HomeModel>> refresh();

  FutureOr<List<HomeModel>> search({
    required String query,
  });

  FutureOr<void> update({
    required HomeEntity home,
  });
}
