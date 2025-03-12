import '../../../../core/shared/shared.dart';
import '../../../category/category.dart';
import '../../../industry/industry.dart';
import '../../../sub_category/sub_category.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class LocationListingsFilterBloc extends Bloc<LocationListingsFilterEvent, LocationListingsFilterState> {
  final FirebaseAnalytics analytics;
  LocationListingsFilterBloc({
    required this.analytics,
  }) : super(DefaultLocationListingsFilterState()) {
    on<ApplyLocationListingsFilter>((event, emit) async {
      await analytics.logEvent(name: 'listings_by_location_filter_apply');
      emit(
        CustomLocationListingsFilterState(
          industry: event.industry,
          category: event.category,
          subCategory: event.subCategory,
          rating: event.rating,
        ),
      );
    });
    on<ResetLocationListingsFilter>((event, emit) async {
      await analytics.logEvent(name: 'listings_by_location_filter_reset');
      emit(DefaultLocationListingsFilterState());
    });
  }
}
