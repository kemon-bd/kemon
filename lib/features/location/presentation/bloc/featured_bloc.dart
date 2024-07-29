import '../../../../core/shared/shared.dart';
import '../../location.dart';

part 'featured_event.dart';
part 'featured_state.dart';

class FeaturedLocationsBloc extends Bloc<FeaturedLocationsEvent, FeaturedLocationsState> {
  final FeaturedLocationsUseCase useCase;
  FeaturedLocationsBloc({
    required this.useCase,
  }) : super(FeaturedLocationsInitial()) {
    on<FeaturedLocations>((event, emit) async {
      emit(const FeaturedLocationsLoading());

      final result = await useCase();

      result.fold(
        (failure) => emit(FeaturedLocationsError(failure: failure)),
        (locations) => emit(FeaturedLocationsDone(locations: locations)),
      );
    });
  }
}
