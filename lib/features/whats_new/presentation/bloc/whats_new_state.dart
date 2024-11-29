part of 'whats_new_bloc.dart';

class WhatsNewState extends Equatable {
  final String hash;
  const WhatsNewState({
    required this.hash,
  });

  factory WhatsNewState.parse({
    required Map<String, dynamic> map,
  }) {
    final String hash = map['hash'] ?? '';
    return WhatsNewState(hash: hash);
  }

  Map<String, dynamic> toMap() {
    return {
      'hash': hash,
    };
  }

  @override
  List<Object> get props => [hash];
}

final class WhatsNewInitial extends WhatsNewState {
  const WhatsNewInitial() : super(hash: '');
}

final class NewUpdate extends WhatsNewState {
  final List<WhatsNewEntity> updates;
  const NewUpdate({
    required this.updates,
    required super.hash,
  });
}

final class UpdateToDate extends WhatsNewState {
  const UpdateToDate({
    required super.hash,
  });
}
