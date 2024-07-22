import '../shared.dart';

class Identity extends Equatable {
  final int id;
  final String guid;

  const Identity({
    required this.id,
    required this.guid,
  });

  factory Identity.guid({
    required String guid,
  }) {
    return Identity(
      id: -1,
      guid: guid,
    );
  }

  factory Identity.id({
    required int id,
  }) {
    return Identity(
      id: id,
      guid: '00000000-0000-0000-0000-000000000000',
    );
  }

  @override
  List<Object?> get props => [id, guid];
}
