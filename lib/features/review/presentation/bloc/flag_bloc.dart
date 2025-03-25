import '../../../../core/shared/shared.dart';
import '../../review.dart';

part 'flag_event.dart';
part 'flag_state.dart';

class FlagBloc extends Bloc<FlagEvent, FlagState> {
  final FlagAReviewUseCase useCase;
  FlagBloc({
    required this.useCase,
  }) : super(FlagInitial()) {
    on<FlagAbuse>((event, emit) async {
      emit(FlagLoading());

      final result = await useCase(reason: event.reason, review: event.review);

      result.fold(
        (failure) => emit(FlagError(failure: failure)),
        (_) => emit(FlagDone()),
      );
    });
  }
}
