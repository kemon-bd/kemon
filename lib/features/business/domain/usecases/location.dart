import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessesByLocationUseCase {
  final BusinessRepository repository;

  BusinessesByLocationUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, BusinessesByLocationPaginatedResponse>> call({
    required int page,
    required String location,
    required String? query,
    required SortBy? sort,
    required List<int> ratings,
  }) async =>
      await repository.location(
        page: page,
        location: location,
        query: query,
        sort: sort,
        ratings: ratings,
      );
}
