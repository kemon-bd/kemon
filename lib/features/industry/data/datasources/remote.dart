import '../../../../core/shared/shared.dart';
import '../../industry.dart';

abstract class IndustryRemoteDataSource {
  FutureOr<List<IndustryModel>> find();
}
