import '../../../../core/shared/shared.dart';
import '../../business.dart';

abstract class BusinessLocalDataSource {
  FutureOr<void> add({
    required BusinessEntity business,
  });

  FutureOr<void> addAll({
    required List<BusinessEntity> items,
  });

  FutureOr<void> update({
    required BusinessEntity business,
  });

  FutureOr<void> remove({
    required String guid,
  });

  FutureOr<void> removeAll();

  FutureOr<BusinessEntity> find({
    required String urlSlug,
  });
}
