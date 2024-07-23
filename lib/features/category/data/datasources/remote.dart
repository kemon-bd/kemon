import '../../../../core/shared/shared.dart';
import '../../category.dart';

abstract class CategoryRemoteDataSource {
  FutureOr<List<CategoryModel>> featured();
}
