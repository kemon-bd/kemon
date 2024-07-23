import '../../../../core/shared/shared.dart';
import '../../location.dart';

part 'featured_event.dart';
part 'featured_state.dart';

class FeaturedLocationBloc
    extends Bloc<FeaturedLocationEvent, FeaturedLocationState> {
  final FeaturedLocationUseCase useCase;
  FeaturedLocationBloc({
    required this.useCase,
  }) : super(FeaturedLocationInitial()) {
    on<FeaturedLocation>((event, emit) async {
      emit(const FeaturedLocationLoading());

      final result = await useCase();

      result.fold(
        (failure) => emit(FeaturedLocationError(failure: failure)),
        (locations) => emit(FeaturedLocationDone(locations: locations)),
      );
    });
  }
}
