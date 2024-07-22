import '../shared.dart';

class Activity extends Equatable {
  final bool active;
  final bool deleted;

  const Activity({
    required this.active,
    required this.deleted,
  });

  @override
  List<Object?> get props => [active, deleted];
}
