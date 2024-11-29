import '../../../../core/shared/shared.dart';
import '../../analytics.dart';

part 'sync_event.dart';
part 'sync_state.dart';

class SyncAnalyticsBloc extends Bloc<SyncAnalyticsEvent, SyncAnalyticsState> {
  final SyncAnalyticsUseCase useCase;
  SyncAnalyticsBloc({required this.useCase}) : super(const SyncAnalyticsInitial()) {
    on<SyncAnalytics>((event, emit) async {
      emit(const SyncAnalyticsLoading());
      final result = await useCase(
        source: event.source,
        referrer: event.referrer,
        listing: event.listing,
      );
      result.fold(
        (failure) => emit(SyncAnalyticsError(failure: failure)),
        (analytics) => emit(SyncAnalyticsDone()),
      );
    });
  }
}
