import '../../../../core/shared/shared.dart';
import '../../whats_new.dart';

part 'whats_new_event.dart';
part 'whats_new_state.dart';

class WhatsNewBloc extends HydratedBloc<WhatsNewEvent, WhatsNewState> {
  WhatsNewBloc() : super(const WhatsNewInitial()) {
    on<CheckForUpdate>((event, emit) async {
      final String payload = await rootBundle.loadString('changelog.json');
      final Map<String, dynamic> map = json.decode(payload);

      final newState = WhatsNewState.parse(map: map);
      if (state.hash.same(as: newState.hash)) {
        emit(UpdateToDate(hash: newState.hash));
      } else {
        final List<WhatsNewEntity> updates = List<dynamic>.from(map['changes'])
            .map(
              (map) => WhatsNewModel.parse(map: map),
            )
            .toList();
        emit(NewUpdate(updates: updates, hash: newState.hash));
      }
    });

    on<UpdateHash>((event, emit) async {
      final newState = UpdateToDate(hash: event.hash);
      emit(newState);
    });
  }

  @override
  WhatsNewState? fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return null;
    return WhatsNewState.parse(map: json);
  }

  @override
  Map<String, dynamic>? toJson(WhatsNewState state) {
    return state.toMap();
  }
}
