import '../../../../core/shared/shared.dart';
import '../../business.dart';

class FindBusinessUseCase {
  final BusinessRepository repository;

  FindBusinessUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, BusinessEntity>> call(
      {required String urlSlug}) async {
    return await repository.find(urlSlug: urlSlug);
  }
}
