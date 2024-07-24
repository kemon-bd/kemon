import '../../../../core/shared/shared.dart';
import '../../review.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindReviewBloc extends Bloc<FindReviewEvent, FindReviewState> {
  final FindReviewUseCase useCase;
  FindReviewBloc({required this.useCase}) : super(const FindReviewInitial()) {
    on<FindReview>((event, emit) async {
      emit(const FindReviewLoading());
      final result = await useCase(user: event.user);
      result.fold(
        (failure) => emit(FindReviewError(failure: failure)),
        (reviews) => emit(FindReviewDone(reviews: reviews)),
      );
    });
  }
}
