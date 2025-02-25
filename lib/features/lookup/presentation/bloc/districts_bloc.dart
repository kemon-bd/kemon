import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

part 'districts_event.dart';
part 'districts_state.dart';

class DistrictsBloc extends Bloc<DistrictsEvent, DistrictsState> {
  final FindLookupUseCase useCase;
  DistrictsBloc({
    required this.useCase,
  }) : super(const DistrictsInitial()) {
    on<FindDistricts>((event, emit) async {
      emit(const DistrictsLoading());
      final result = await useCase(
        key: (key: Lookups.district, parent: event.division),
      );
      result.fold(
        (failure) => emit(DistrictsError(failure: failure)),
        (lookups) => emit(DistrictsDone(districts: lookups)),
      );
    });
  }
}
