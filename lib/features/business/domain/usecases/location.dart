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
    required String? division,
    required String? district,
    required String? thana,
    required String? query,
    required SortBy? sort,
    required List<int> ratings,
  }) async =>
      await repository.location(
        page: page,
        location: location,
        division: division,
        district: district,
        thana: thana,
        query: query,
        sort: sort,
        ratings: ratings,
      );
}
