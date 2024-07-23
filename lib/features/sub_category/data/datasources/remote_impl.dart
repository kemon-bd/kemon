import '../../../../core/shared/shared.dart';
import '../../sub_category.dart';

class SubCategoryRemoteDataSourceImpl extends SubCategoryRemoteDataSource {
  final Client client;

  SubCategoryRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<List<SubCategoryModel>> category({
    required String category,
  }) async {
    throw UnimplementedError();
  }
}
