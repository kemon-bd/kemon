import '../../../../core/shared/shared.dart';
import '../../industry.dart';

part 'location_event.dart';
part 'location_state.dart';

class FindIndustriesByLocationBloc extends Bloc<FindIndustriesByLocationEvent, FindIndustriesByLocationState> {
  final FindIndustriesByLocationUseCase useCase;
  FindIndustriesByLocationBloc({
    required this.useCase,
  }) : super(FindIndustriesByLocationInitial()) {
    on<FindIndustriesByLocation>((event, emit) async {
      emit(FindIndustriesByLocationLoading());

      final result = await useCase(
        query: null,
        division: event.division,
        district: event.district,
        thana: event.thana,
      );
      result.fold(
        (failure) => emit(FindIndustriesByLocationError(failure: failure)),
        (industries) => emit(FindIndustriesByLocationDone(industries: industries)),
      );
    });
    on<SearchIndustriesByLocation>((event, emit) async {
      emit(FindIndustriesByLocationLoading());

      final result = await useCase(
        query: event.query,
        division: event.division,
        district: event.district,
        thana: event.thana,
      );
      result.fold(
        (failure) => emit(FindIndustriesByLocationError(failure: failure)),
        (industries) => emit(FindIndustriesByLocationDone(industries: industries)),
      );
    });
  }
}
