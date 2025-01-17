import '../../../../core/shared/shared.dart';
import '../../business.dart';

class RefreshBusinessesByLocationUseCase {
  final BusinessRepository repository;

  RefreshBusinessesByLocationUseCase({
    required this.repository,
  });

  FutureOr<Either<Failure, BusinessesByLocationPaginatedResponse>> call({
    required String location,
    required String? division,
    required String? district,
    required String? thana,
    required String? query,
    required SortBy? sort,
    required List<int> ratings,
  }) async =>
      await repository.refreshLocation(
        location: location,
        division: division,
        district: district,
        thana: thana,
        query: query,
        sort: sort,
        ratings: ratings,
      );
}
