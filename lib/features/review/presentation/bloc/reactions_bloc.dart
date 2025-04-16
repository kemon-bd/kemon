import '../../../../core/shared/shared.dart';
import '../../review.dart';

part 'reactions_event.dart';
part 'reactions_state.dart';

class FindReviewReactionsBloc extends Bloc<FindReviewReactionsEvent, FindReviewReactionsState> {
  final FindReviewReactionsUseCase find;
  FindReviewReactionsBloc({
    required this.find,
  }) : super(const FindReviewReactionsInitial()) {
    on<FindReviewReactions>((event, emit) async {
      emit(const FindReviewReactionsLoading());
      final result = await find(review: event.review);
      result.fold(
        (failure) => emit(FindReviewReactionsError(failure: failure)),
        (reactions) => emit(FindReviewReactionsDone(reactions: reactions)),
      );
    });
  }
}
