import '../../../../core/shared/shared.dart';
import '../../review.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindUserReviewsBloc
    extends Bloc<FindUserReviewsEvent, FindUserReviewsState> {
  final FindUserReviewsUseCase useCase;
  FindUserReviewsBloc({required this.useCase})
      : super(const FindUserReviewsInitial()) {
    on<FindUserReviews>((event, emit) async {
      emit(const FindUserReviewsLoading());
      final result = await useCase(user: event.user);
      result.fold(
        (failure) => emit(FindUserReviewsError(failure: failure)),
        (reviews) => emit(FindUserReviewsDone(reviews: reviews)),
      );
    });
  }
}
