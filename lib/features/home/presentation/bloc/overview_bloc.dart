import '../../../../core/shared/shared.dart';
import '../../../business/business.dart';
import '../../../category/category.dart';
import '../../../location/location.dart';
import '../../../review/review.dart';
import '../../home.dart';

part 'overview_event.dart';
part 'overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final HomeOverviewUsecase usecase;
  OverviewBloc({
    required this.usecase,
  }) : super(OverviewInitial()) {
    on<FetchOverview>((event, emit) async {
      emit(OverviewLoading());

      final result = await usecase.call();
      result.fold(
        (failure) => emit(OverviewError(failure: failure)),
        (response) => emit(
          OverviewDone(
            categories: response.$1,
            locations: response.$2,
            reviews: response.$3,
            businesses: response.$4,
          ),
        ),
      );
    });
  }
}
