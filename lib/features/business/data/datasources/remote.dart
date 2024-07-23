import '../../../../core/shared/shared.dart';
import '../../business.dart';

abstract class BusinessRemoteDataSource {
  FutureOr<BusinessModel> find({
    required String urlSlug,
  });

  FutureOr<List<BusinessModel>> category({
    required String urlSlug,
  });
}
