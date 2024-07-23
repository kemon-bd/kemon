import '../../../../core/shared/shared.dart';
import '../../industry.dart';

abstract class IndustryLocalDataSource {
  FutureOr<void> addAll({
    required List<IndustryEntity> items,
  });

  FutureOr<void> removeAll();

  FutureOr<List<IndustryEntity>> find();
}
