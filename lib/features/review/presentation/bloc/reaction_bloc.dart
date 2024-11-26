import '../../../../core/shared/shared.dart';
import '../../review.dart';

part 'reaction_event.dart';
part 'reaction_state.dart';

class ReactionBloc extends Bloc<ReactionEvent, ReactionState> {
  final FindReviewReactionsUseCase useCase;
  ReactionBloc({
    required this.useCase,
  }) : super(ReactionInitial()) {
    on<FindReaction>((event, emit) async {
      emit(ReactionLoading());
      final result = await useCase(review: event.review);
      result.fold(
        (failure) => emit(ReactionError(failure: failure)),
        (reactions) => emit(ReactionDone(reactions: reactions)),
      );
    });
  }
}
