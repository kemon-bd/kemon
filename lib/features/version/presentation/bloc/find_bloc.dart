import '../../../../core/shared/shared.dart';
import '../../version.dart';

part 'find_event.dart';
part 'find_state.dart';

class FindVersionBloc extends Bloc<FindVersionEvent, FindVersionState> {
  final FindVersionUseCase useCase;
  FindVersionBloc({required this.useCase}) : super(const FindVersionInitial()) {
    on<FindVersion>((event, emit) async {
      emit(const FindVersionLoading());
      final result = await useCase();

      final PackageInfo packageInfo = await PackageInfo.fromPlatform();

      result.fold(
        (failure) => emit(FindVersionError(failure: failure)),
        (production) async {
          final context = event.context;
          final String current = packageInfo.version;

          final int currentVersion = current.version;
          final int productionVersion = production.version.version;

          if (isClosed) return;

          if (productionVersion > currentVersion) {
            await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              barrierColor: context.barrierColor,
              constraints: BoxConstraints(
                maxHeight: context.height * .85,
                maxWidth: context.width,
                minHeight: 0,
                minWidth: 0,
              ),
              isDismissible: false,
              enableDrag: false,
              builder: (_) => NewUpdateDialog(
                version: production.version,
                updates: production.updates,
              ),
            );
          }
          emit(const FindVersionDone());
        },
      );
    });
  }
}
