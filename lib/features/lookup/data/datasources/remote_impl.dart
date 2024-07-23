import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

class LookupRemoteDataSourceImpl extends LookupRemoteDataSource {
  final Client client;

  LookupRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<List<LookupModel>> find({
    required LookupKey key,
    String? parent,
  }) async {
    throw UnimplementedError();
  }
}
