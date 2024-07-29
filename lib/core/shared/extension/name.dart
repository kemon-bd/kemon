import '../shared.dart';

extension NameExtension on Name {
  String get full {
    return '${first.trim()} ${last.trim()}'.trim();
  }

  String get symbol => '${full.isNotEmpty ? full.substring(0, 1) : ""}${full.isNotEmpty ? full.substring(0, 1) : ""}'.trim();
}
