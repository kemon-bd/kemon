import '../../../../core/shared/shared.dart';
import '../../review.dart';

part 'delete_event.dart';
part 'delete_state.dart';

class DeleteReviewBloc extends Bloc<DeleteReviewEvent, DeleteReviewState> {
  final DeleteReviewUseCase useCase;
  DeleteReviewBloc({required this.useCase})
      : super(const DeleteReviewInitial()) {
    on<DeleteReview>((event, emit) async {
      emit(const DeleteReviewLoading());
      final result = await useCase(review: event.review);
      result.fold(
        (failure) => emit(DeleteReviewError(failure: failure)),
        (_) => emit(const DeleteReviewDone()),
      );
    });
  }
}
