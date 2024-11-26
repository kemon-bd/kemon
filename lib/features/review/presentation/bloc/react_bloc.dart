import '../../../../core/shared/shared.dart';
import '../../review.dart';

part 'react_event.dart';
part 'react_state.dart';

class ReactOnReviewBloc extends Bloc<ReactOnReviewEvent, ReactOnReviewState> {
  final ReactOnReviewUseCase useCase;
  ReactOnReviewBloc({
    required this.useCase,
  }) : super(ReactOnReviewInitial()) {
    on<ReactOnReview>((event, emit) async {
      emit(ReactOnReviewLoading());
      final result = await useCase(
        review: event.review,
        reaction: event.reaction,
      );
      result.fold(
        (failure) => emit(ReactOnReviewError(failure: failure)),
        (r) => emit(ReactOnReviewDone()),
      );
    });
  }
}
