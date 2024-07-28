import '../../../../core/shared/shared.dart';
import '../../review.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class FindListingReviewsBloc extends Bloc<FindListingReviewsEvent, FindListingReviewsState> {
  final FindListingReviewUseCase useCase;
  FindListingReviewsBloc({required this.useCase}) : super(const FindListingReviewsInitial()) {
    on<FindListingReviews>((event, emit) async {
      emit(const FindListingReviewsLoading());
      final result = await useCase(urlSlug: event.urlSlug);
      result.fold(
        (failure) => emit(FindListingReviewsError(failure: failure)),
        (reviews) => emit(FindListingReviewsDone(reviews: reviews)),
      );
    });
  }
}
