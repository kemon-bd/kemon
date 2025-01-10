import '../../../../core/shared/shared.dart';
import '../../analytics.dart';

class AnalyticsModel extends AnalyticsEntity {
  const AnalyticsModel({
    required super.identity,
  });

  factory AnalyticsModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      throw UnimplementedError();
    } catch (e, stackTrace) {
      throw AnalyticsModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
