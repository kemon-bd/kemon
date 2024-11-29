import '../../../../core/shared/shared.dart';
import '../../business.dart';

class RefreshBusinessesByLocationUseCase {
  final BusinessRepository repository;

  RefreshBusinessesByLocationUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, BusinessesByLocationPaginatedResponse>> call({
    required String location,
    required String? query,
    required SortBy? sort,
    required List<int> ratings,
  }) async =>
      await repository.refreshLocation(
        location: location,
        query: query,
        sort: sort,
        ratings: ratings,
      );
}
