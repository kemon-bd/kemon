import '../../../../core/shared/shared.dart';
import '../../analytics.dart';

class AnalyticsModel extends AnalyticsEntity {
  // TODO: implement model properties
  AnalyticsModel({
    required super.identity,
  });

  factory AnalyticsModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      // TODO: implement parse
      throw UnimplementedError();
    } catch (e, stackTrace) {
      throw AnalyticsModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
