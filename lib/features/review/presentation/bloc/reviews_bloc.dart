import '../../../../core/shared/shared.dart';
import '../../review.dart';

part 'reviews_event.dart';
part 'reviews_state.dart';

class FindListingReviewsBloc extends Bloc<FindListingReviewsEvent, FindListingReviewsState> {
  final FindListingReviewUseCase useCase;
  FindListingReviewsBloc({required this.useCase}) : super(const FindListingReviewsInitial()) {
    on<FindListingReviews>((event, emit) async {
      emit(FindListingReviewsLoading(filter: event.filter));
      final result = await useCase(
        urlSlug: event.urlSlug,
      );
      result.fold(
        (failure) => emit(FindListingReviewsError(
          failure: failure,
          filter: event.filter,
        )),
        (reviews) => emit(FindListingReviewsDone(
          reviews: reviews,
          filter: event.filter,
        )),
      );
    });
    on<RefreshListingReviews>((event, emit) async {
      emit(FindListingReviewsLoading(filter: event.filter));
      final result = await useCase(
        urlSlug: event.urlSlug,
        refresh: true,
      );
      result.fold(
        (failure) => emit(FindListingReviewsError(
          failure: failure,
          filter: event.filter,
        )),
        (reviews) => emit(FindListingReviewsDone(
          reviews: reviews,
          filter: event.filter,
        )),
      );
    });
  }
}
