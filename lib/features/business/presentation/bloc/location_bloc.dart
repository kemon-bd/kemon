import '../../../../core/shared/shared.dart';
import '../../business.dart';

part 'location_event.dart';
part 'location_state.dart';

class FindBusinessesByLocationBloc extends Bloc<FindBusinessesByLocationEvent, FindBusinessesByLocationState> {
  final BusinessesByLocationUseCase find;
  final RefreshBusinessesByLocationUseCase refresh;
  FindBusinessesByLocationBloc({
    required this.find,
    required this.refresh,
  }) : super(const FindBusinessesByLocationInitial()) {
    on<FindBusinessesByLocation>((event, emit) async {
      emit(FindBusinessesByLocationLoading());
      final result = await find(
        division: event.division,
        district: event.district,
        thana: event.thana,
        query: event.query,
        category: event.category,
        industry: event.industry,
        subCategory: event.subCategory,
        sort: event.sort,
        ratings: event.ratings,
      );
      result.fold(
        (failure) => emit(FindBusinessesByLocationError(failure: failure)),
        (businesses) => emit(FindBusinessesByLocationDone(businesses: businesses)),
      );
    });

    on<RefreshBusinessesByLocation>((event, emit) async {
      emit(FindBusinessesByLocationLoading());
      final result = await refresh(
        division: event.division,
        district: event.district,
        thana: event.thana,
        query: event.query,
        category: event.category,
        industry: event.industry,
        subCategory: event.subCategory,
        sort: event.sort,
        ratings: event.ratings,
      );
      result.fold(
        (failure) => emit(FindBusinessesByLocationError(failure: failure)),
        (businesses) => emit(FindBusinessesByLocationDone(businesses: businesses)),
      );
    });
  }
}
