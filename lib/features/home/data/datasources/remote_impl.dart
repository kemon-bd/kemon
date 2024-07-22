import '../../../../core/shared/shared.dart';
import '../../home.dart';

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final Client client;

  HomeRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<void> create({
    required HomeEntity home,
  }) async {
    throw UnimplementedError();
  }

  @override
  FutureOr<void> delete({
    required int id,
  }) async {
    throw UnimplementedError();
  }

  @override
  FutureOr<HomeModel> find({
    required int id,
  }) async {
    throw UnimplementedError();
  }

  @override
  FutureOr<List<HomeModel>> read() async {
    throw UnimplementedError();
  }

  @override
  FutureOr<List<HomeModel>> refresh() async {
    throw UnimplementedError();
  }

  @override
  FutureOr<List<HomeModel>> search({
    required String query,
  }) async {
    throw UnimplementedError();
  }

  @override
  FutureOr<void> update({
    required HomeEntity home,
  }) async {
    throw UnimplementedError();
  }
}
