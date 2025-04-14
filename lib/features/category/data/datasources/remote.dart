import '../../../../core/shared/shared.dart';
import '../../../industry/industry.dart';
import '../../category.dart';

abstract class CategoryRemoteDataSource {
  FutureOr<List<CategoryModel>> featured();

  FutureOr<CategoryModel> find({
    required String urlSlug,
  });

  FutureOr<List<CategoryModel>> industry({
    required Identity identity,
  });

  FutureOr<CategoryModel> deeplink({
    required String urlSlug,
  });

  FutureOr<List<IndustryWithListingCountModel>> all({
    required String? query,
  });
}
