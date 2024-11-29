import '../../../../core/shared/shared.dart';
import '../../../location/location.dart';
import '../../business.dart';

part 'location_event.dart';
part 'location_state.dart';

class FindBusinessesByLocationBloc
    extends Bloc<FindBusinessesByLocationEvent, FindBusinessesByLocationState> {
  final BusinessesByLocationUseCase find;
  final RefreshBusinessesByLocationUseCase refresh;
  FindBusinessesByLocationBloc({
    required this.find,
    required this.refresh,
  }) : super(const FindBusinessesByLocationInitial()) {
    on<FindBusinessesByLocation>((event, emit) async {
      emit(FindBusinessesByLocationLoading(
        query: event.query ?? '',
        sortBy: event.sort ?? SortBy.recommended,
        ratings: event.ratings,
      ));
      final result = await find(
        location: event.location,
        page: 1,
        query: event.query ?? '',
        sort: event.sort ?? SortBy.recommended,
        ratings: event.ratings,
      );
      result.fold(
        (failure) => emit(FindBusinessesByLocationError(
          failure: failure,
          query: event.query ?? '',
          sortBy: event.sort ?? SortBy.recommended,
          ratings: event.ratings,
        )),
        (response) => emit(
          FindBusinessesByLocationDone(
            page: 1,
            total: response.total,
            businesses: response.businesses,
            related: response.related,
            query: event.query ?? '',
            sortBy: event.sort ?? SortBy.recommended,
            ratings: event.ratings,
          ),
        ),
      );
    });

    on<RefreshBusinessesByLocation>((event, emit) async {
      emit(FindBusinessesByLocationLoading(
        query: event.query ?? '',
        sortBy: event.sort ?? SortBy.recommended,
        ratings: event.ratings,
      ));
      final result = await refresh(
        location: event.location,
        query: event.query ?? '',
        sort: event.sort ?? SortBy.recommended,
        ratings: event.ratings,
      );
      result.fold(
        (failure) => emit(FindBusinessesByLocationError(
          failure: failure,
          query: event.query ?? '',
          sortBy: event.sort ?? SortBy.recommended,
          ratings: event.ratings,
        )),
        (response) => emit(
          FindBusinessesByLocationDone(
            page: 1,
            total: response.total,
            businesses: response.businesses,
            related: response.related,
            query: event.query ?? '',
            sortBy: event.sort ?? SortBy.recommended,
            ratings: event.ratings,
          ),
        ),
      );
    });

    on<PaginateBusinessesByLocation>((event, emit) async {
      if (state is! FindBusinessesByLocationPaginating) {
        final oldState = (state as FindBusinessesByLocationDone);
        emit(FindBusinessesByLocationPaginating(
          total: oldState.total,
          page: event.page,
          businesses: oldState.businesses,
          related: oldState.related,
          query: event.query ?? '',
          sortBy: event.sort ?? SortBy.recommended,
          ratings: event.ratings,
        ));
        final result = await find(
          location: event.location,
          page: event.page,
          query: event.query ?? '',
          sort: event.sort ?? SortBy.recommended,
          ratings: event.ratings,
        );
        result.fold(
          (failure) => emit(FindBusinessesByLocationError(
            failure: failure,
            query: event.query ?? '',
            sortBy: event.sort ?? SortBy.recommended,
            ratings: event.ratings,
          )),
          (response) => emit(
            FindBusinessesByLocationDone(
              page: event.page,
              total: response.total,
              businesses: response.businesses,
              related: response.related,
              query: event.query ?? '',
              sortBy: event.sort ?? SortBy.recommended,
              ratings: event.ratings,
            ),
          ),
        );
      }
    });
  }
}
