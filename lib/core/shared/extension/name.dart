import '../shared.dart';

extension NameExtension on Name {
  String get full {
    return '${first.trim()} ${last.trim()}'.trim();
  }
}
