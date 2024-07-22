import '../../../../core/shared/shared.dart';
import '../../home.dart';

class HomeModel extends HomeEntity {
  // TODO: implement model properties
  HomeModel({
    required super.id,
  });

  factory HomeModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      // TODO: implement parse
      throw UnimplementedError();
    } catch (e, stackTrace) {
      throw HomeModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
