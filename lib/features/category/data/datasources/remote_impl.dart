import '../../../../core/shared/shared.dart';
import '../../category.dart';

class CategoryRemoteDataSourceImpl extends CategoryRemoteDataSource {
  final Client client;

  CategoryRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<List<CategoryModel>> featured() async {
    throw UnimplementedError();
  }
}
