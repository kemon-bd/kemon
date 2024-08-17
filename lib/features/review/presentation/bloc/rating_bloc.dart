import '../../../../core/shared/shared.dart';
import '../../review.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class FindRatingBloc extends Bloc<FindRatingEvent, FindRatingState> {
  final FindRatingUseCase find;
  FindRatingBloc({
    required this.find,
  }) : super(const FindRatingInitial()) {
    on<FindRating>((event, emit) async {
      emit(const FindRatingLoading());
      final result = await find(urlSlug: event.urlSlug);
      result.fold(
        (failure) => emit(FindRatingError(failure: failure)),
        (rating) => emit(FindRatingDone(rating: rating)),
      );
    });
    on<RefreshRating>((event, emit) async {
      emit(const FindRatingLoading());
      final result = await find(urlSlug: event.urlSlug, refresh: true);
      result.fold(
        (failure) => emit(FindRatingError(failure: failure)),
        (rating) => emit(FindRatingDone(rating: rating)),
      );
    });
    on<RefreshRating>((event, emit) async {
      emit(const FindRatingLoading());
      final result = await useCase(urlSlug: event.urlSlug);
      result.fold(
        (failure) => emit(FindRatingError(failure: failure)),
        (rating) => emit(FindRatingDone(rating: rating)),
      );
    });
  }
}
