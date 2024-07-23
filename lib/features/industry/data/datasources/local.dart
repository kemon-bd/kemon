import '../../../../core/shared/shared.dart';
import '../../industry.dart';

abstract class IndustryLocalDataSource {
  FutureOr<void> add({
    required IndustryEntity industry,
  });

  FutureOr<void> addAll({
    required List<IndustryEntity> industries,
  });

  FutureOr<void> removeAll();

  FutureOr<List<IndustryEntity>> find();
}
