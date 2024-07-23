import '../../../../core/shared/shared.dart';

class BusinessEntity extends Equatable {
  // TODO: implement entity properties
  final String guid;

  BusinessEntity({
    required this.guid,
  });

  factory BusinessEntity.create() {
    throw UnimplementedError();
  }

  @override
  List<Object?> get props => [
        // TODO: add entity properties
        guid,
      ];
}
