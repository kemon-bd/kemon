import '../../../../core/shared/shared.dart';
import '../../../review/review.dart';
import '../../business.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindBusinessBloc extends Bloc<FindBusinessEvent, FindBusinessState> {
  final FindBusinessUseCase find;
  final RefreshBusinessUseCase refresh;
  FindBusinessBloc({
    required this.find,
    required this.refresh,
  }) : super(const FindBusinessInitial()) {
    on<FindBusiness>((event, emit) async {
      emit(const FindBusinessLoading());
      final result = await find(urlSlug: event.urlSlug, filter: event.filter);
      result.fold(
        (failure) => emit(FindBusinessError(failure: failure)),
        (listing) => emit(FindBusinessDone(
          business: listing.$1,
          insights: listing.$2,
          reviews: listing.$3,
          hasMyReview: listing.$4,
          filter: event.filter,
        )),
      );
    });
    on<RefreshBusiness>((event, emit) async {
      emit(const FindBusinessLoading());
      final result = await refresh(urlSlug: event.urlSlug);
      result.fold(
        (failure) => emit(FindBusinessError(failure: failure)),
        (listing) => emit(FindBusinessDone(
          business: listing.$1,
          insights: listing.$2,
          reviews: listing.$3,
          hasMyReview: listing.$4,
          filter: [],
        )),
      );
    });
  }
}
