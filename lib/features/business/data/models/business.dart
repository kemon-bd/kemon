import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessModel extends BusinessEntity {
  // TODO: implement model properties
  BusinessModel({
    required super.guid,
  });

  factory BusinessModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      // TODO: implement parse
      throw UnimplementedError();
    } catch (e, stackTrace) {
      throw BusinessModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
