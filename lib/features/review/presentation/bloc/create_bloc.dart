import '../../../../core/shared/shared.dart';
import '../../review.dart';

part 'create_event.dart';
part 'create_state.dart';

class CreateReviewBloc extends Bloc<CreateReviewEvent, CreateReviewState> {
  final CreateReviewUseCase useCase;
  CreateReviewBloc({required this.useCase}) : super(const CreateReviewInitial()) {
    on<CreateReview>((event, emit) async {
      emit(const CreateReviewLoading());
      final result = await useCase(
        listing: event.listing,
        rating: event.rating,
        title: event.title,
        description: event.description,
        date: event.date,
        attachments: event.attachments,
      );
      result.fold(
        (failure) => emit(CreateReviewError(failure: failure)),
        (_) => emit(const CreateReviewDone()),
      );
    });
  }
}
