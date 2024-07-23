import '../../../../core/shared/shared.dart';
import '../../industry.dart';

abstract class IndustryRepository {
  FutureOr<Either<Failure, List<IndustryEntity>>> find();
}
