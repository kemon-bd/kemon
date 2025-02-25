import '../../../../core/shared/shared.dart';
import '../../business.dart';

part 'url_slug_event.dart';
part 'url_slug_state.dart';

class ValidateUrlSlugBloc extends Bloc<ValidateUrlSlugEvent, ValidateUrlSlugState> {
  final ValidateUrlSlugUseCase useCase;
  ValidateUrlSlugBloc({
    required this.useCase,
  }) : super(ValidateUrlSlugInitial()) {
    on<ValidateUrlSlug>((event, emit) async {
      emit(ValidateUrlSlugLoading());

      final result = await useCase(urlSlug: event.urlSlug);

      result.fold(
        (failure) => emit(ValidateUrlSlugError(failure: failure)),
        (_) => emit(ValidateUrlSlugDone()),
      );
    });
  }
}
