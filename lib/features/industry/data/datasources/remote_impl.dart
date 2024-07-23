import '../../../../core/shared/shared.dart';
import '../../industry.dart';

class IndustryRemoteDataSourceImpl extends IndustryRemoteDataSource {
  final Client client;

  IndustryRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<List<IndustryModel>> find() async {
    throw UnimplementedError();
  }
}
