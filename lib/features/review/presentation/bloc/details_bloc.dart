import '../../../../core/shared/shared.dart';
import '../../review.dart';

part 'details_event.dart';
part 'details_state.dart';

class FindReviewDetailsBloc extends Bloc<FindReviewDetailsEvent, FindReviewDetailsState> {
  final FindReviewDetailsUseCase find;
  final RefreshReviewDetailsUseCase refresh;
  FindReviewDetailsBloc({
    required this.find,
    required this.refresh,
  }) : super(const FindReviewDetailsInitial()) {
    on<FindReviewDetails>((event, emit) async {
      emit(const FindReviewDetailsLoading());
      final result = await find(review: event.review);
      result.fold(
        (failure) => emit(FindReviewDetailsError(failure: failure)),
        (review) => emit(FindReviewDetailsDone(review: review)),
      );
    });
    on<RefreshReviewDetails>((event, emit) async {
      emit(const FindReviewDetailsLoading());
      final result = await refresh(review: event.review);
      result.fold(
        (failure) => emit(FindReviewDetailsError(failure: failure)),
        (review) => emit(FindReviewDetailsDone(review: review)),
      );
    });
  }
}
