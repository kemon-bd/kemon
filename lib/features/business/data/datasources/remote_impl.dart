import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessRemoteDataSourceImpl extends BusinessRemoteDataSource {
  final Client client;

  BusinessRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<List<BusinessModel>> category({required   urlSlug}) {
    // TODO: implement category
    throw UnimplementedError();
  }

  @override
  FutureOr<BusinessModel> find({required String urlSlug}) {
    // TODO: implement find
    throw UnimplementedError();
  }
}
