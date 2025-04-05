import '../../../../core/shared/shared.dart';
import '../../version.dart';

class FindVersionUseCase {
  final VersionRepository repository;

  FindVersionUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, VersionUpdate>> call() async {
    return await repository.find();
  }
}
