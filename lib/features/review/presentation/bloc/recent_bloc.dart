import '../../../../core/shared/shared.dart';
import '../../review.dart';

part 'recent_event.dart';
part 'recent_state.dart';

class RecentReviewsBloc extends Bloc<RecentReviewsEvent, RecentReviewsState> {
  final RecentReviewsUseCase useCase;
  RecentReviewsBloc({
    required this.useCase,
  }) : super(RecentReviewsInitial()) {
    on<RecentReviews>((event, emit) async {
      emit(const RecentReviewsLoading());
      final result = await useCase();
      result.fold(
        (failure) => emit(RecentReviewsError(failure: failure)),
        (reviews) => emit(RecentReviewsDone(reviews: reviews)),
      );
    });
  }
}
