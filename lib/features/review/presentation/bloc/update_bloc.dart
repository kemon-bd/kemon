import '../../../../core/shared/shared.dart';
import '../../review.dart';

part 'update_event.dart';
part 'update_state.dart';

class UpdateReviewBloc extends Bloc<UpdateReviewEvent, UpdateReviewState> {
  final UpdateReviewUseCase useCase;
  UpdateReviewBloc({required this.useCase})
      : super(const UpdateReviewInitial()) {
    on<UpdateReview>((event, emit) async {
      emit(const UpdateReviewLoading());
      final result = await useCase(review: event.review);
      result.fold(
        (failure) => emit(UpdateReviewError(failure: failure)),
        (_) => emit(const UpdateReviewDone()),
      );
    });
  }
}
