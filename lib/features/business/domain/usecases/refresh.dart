import '../../../../core/shared/shared.dart';
import '../../business.dart';

class RefreshBusinessUseCase {
  final BusinessRepository repository;

  RefreshBusinessUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, BusinessEntity>> call(
      {required String urlSlug}) async {
    return await repository.refresh(urlSlug: urlSlug);
  }
}
