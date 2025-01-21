import '../../../../core/shared/shared.dart';
import '../../../lookup/lookup.dart';
import '../../../sub_category/sub_category.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class CategoryListingsFilterBloc extends Bloc<CategoryListingsFilterEvent, CategoryListingsFilterState> {
  final FirebaseAnalytics analytics;
  CategoryListingsFilterBloc({
    required this.analytics,
  }) : super(DefaultCategoryListingsFilterState()) {
    on<ApplyCategoryListingsFilter>((event, emit) async {
      await analytics.logEvent(name: 'listings_by_category_filter_apply');
      emit(
        CustomCategoryListingsFilterState(
          subCategory: event.subCategory,
          division: event.division,
          district: event.district,
          thana: event.thana,
          rating: event.rating,
        ),
      );
    });
    on<ResetCategoryListingsFilter>((event, emit) async {
      await analytics.logEvent(name: 'listings_by_category_filter_reset');
      emit(DefaultCategoryListingsFilterState());
    });
  }
}
