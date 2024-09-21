part of 'whats_new_bloc.dart';

sealed class WhatsNewEvent extends Equatable {
  const WhatsNewEvent();

  @override
  List<Object> get props => [];
}

class CheckForUpdate extends WhatsNewEvent {
  const CheckForUpdate();
}

class UpdateHash extends WhatsNewEvent {
  final String hash;
  const UpdateHash({
    required this.hash,
  });
}
