import '../../../../core/shared/shared.dart';
import '../../business.dart';

abstract class BusinessRemoteDataSource {
  FutureOr<BusinessModel> find({
    required String urlSlug,
  });

  FutureOr<BusinessesByCategoryPaginatedResponse> category({
    required int page,
    required String urlSlug,
  });
}
