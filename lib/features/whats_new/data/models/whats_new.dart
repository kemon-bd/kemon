import '../../../../core/shared/shared.dart';
import '../../whats_new.dart';

class WhatsNewModel extends WhatsNewEntity {
  const WhatsNewModel({
    required super.type,
    required super.title,
    required super.description,
  });

  factory WhatsNewModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      assert(
        map.containsKey('type'),
        'WhatsNewModel.parse: \'type\' is not found.',
      );
      assert(
        map['type'] is String,
        'WhatsNewModel.parse: \'type\' is not a String',
      );
      final String type = map['type'];

      assert(
        map.containsKey('title'),
        'WhatsNewModel.parse: \'title\' is not found.',
      );
      assert(
        map['title'] is String,
        'WhatsNewModel.parse: \'title\' is not a String',
      );
      final String title = map['title'];

      assert(
        map['description'] is String?,
        'WhatsNewModel.parse: \'description\' is not a String?',
      );
      final String? description = map['description'];

      return WhatsNewModel(
        type: type.toWhatsNewType,
        title: title,
        description: description,
      );
    } catch (e, stackTrace) {
      throw WhatsNewModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
