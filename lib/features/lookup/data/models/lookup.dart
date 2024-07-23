import '../../../../core/shared/shared.dart';
import '../../lookup.dart';

class LookupModel extends LookupEntity {
  final int order;
  final bool active;

  const LookupModel({
    required super.text,
    required super.value,
    required this.order,
    required this.active,
  });

  factory LookupModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      assert(
        map.containsKey('displayText'),
        'LookupModel.parse: "displayText" not found.',
      );
      assert(
        map['displayText'] is String,
        'LookupModel.parse: "displayText" is not a String.',
      );
      final String text = map['displayText'] as String;

      assert(
        map.containsKey('dataValue'),
        'LookupModel.parse: "dataValue" not found.',
      );
      assert(
        map['dataValue'] is String,
        'LookupModel.parse: "dataValue" is not a String.',
      );
      final String value = map['dataValue'] as String;

      assert(
        map.containsKey('dataOrder'),
        'LookupModel.parse: "dataOrder" not found.',
      );
      assert(
        map['dataOrder'] is int,
        'LookupModel.parse: "dataOrder" is not a int.',
      );
      final int order = map['dataOrder'] as int;

      assert(
        map.containsKey('isActive'),
        'LookupModel.parse: "isActive" not found.',
      );
      assert(
        map['isActive'] is bool,
        'LookupModel.parse: "isActive" is not a bool.',
      );
      final bool active = map['dataValue'] as bool;

      return LookupModel(
        text: text,
        value: value,
        order: order,
        active: active,
      );
    } catch (e, stackTrace) {
      throw LookupModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
