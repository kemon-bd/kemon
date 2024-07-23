import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../industry.dart';

typedef IndustryResponse = ({IndustryModel industry, List<CategoryModel> categories});

class IndustryRemoteDataSourceImpl extends IndustryRemoteDataSource {
  final Client client;

  IndustryRemoteDataSourceImpl({
    required this.client,
  });

  @override
  FutureOr<List<IndustryResponse>> find() async {
    throw UnimplementedError();
  }
}
