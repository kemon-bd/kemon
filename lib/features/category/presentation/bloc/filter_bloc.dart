import '../../../../core/shared/shared.dart';
import '../../../location/location.dart';
import '../../../sub_category/sub_category.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(const DefaultFilter()) {
    on<ApplyFilter>((event, emit) {
      emit(
        FilterState(
          sortBy: event.sortBy,
          division: event.division,
          district: event.district,
          thana: event.thana,
          subCategory: event.subCategory,
          ratings: event.ratings,
        ),
      );
    });
  }
}
