import '../../../../core/shared/shared.dart';
import '../../business.dart';

abstract class BusinessLocalDataSource {
  FutureOr<void> add({
    required BusinessEntity business,
  });

  FutureOr<void> addCategory({
    required int page,
    required String category,
    required BusinessesByCategoryPaginatedResponse response,
  });

  FutureOr<void> addAll({
    required List<BusinessEntity> businesses,
  });

  FutureOr<void> removeAll();

  FutureOr<BusinessEntity> find({
    required String urlSlug,
  });

  FutureOr<BusinessesByCategoryPaginatedResponse> findCategory({
    required int page,
    required String urlSlug,
  });
}
