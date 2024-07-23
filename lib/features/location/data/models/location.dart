import '../../../../core/shared/shared.dart';
import '../../location.dart';

class LocationModel extends LocationEntity {
  // TODO: implement model properties
  LocationModel({
    required super.guid,
  });

  factory LocationModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      // TODO: implement parse
      throw UnimplementedError();
    } catch (e, stackTrace) {
      throw LocationModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
