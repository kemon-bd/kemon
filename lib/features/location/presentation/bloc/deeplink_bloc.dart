import '../../../../core/shared/shared.dart';
import '../../location.dart';

part 'deeplink_event.dart';
part 'deeplink_state.dart';

class LocationDeeplinkBloc extends Bloc<LocationDeeplinkEvent, LocationDeeplinkState> {
  final FindLocationDeeplinkUseCase useCase;

  LocationDeeplinkBloc({
    required this.useCase,
  }) : super(LocationDeeplinkInitial()) {
    on<LocationDeeplink>((event, emit) async {
      emit(LocationDeeplinkLoading());
      final result = await useCase(urlSlug: event.urlSlug);
      result.fold(
        (failure) => emit(LocationDeeplinkError(failure: failure)),
        (category) => emit(LocationDeeplinkDone(location: category)),
      );
    });
  }
}
