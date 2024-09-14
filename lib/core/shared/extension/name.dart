import '../shared.dart';

extension NameExtension on Name {
  String get full {
    return '${first.trim()} ${last.trim()}'.trim();
  }

  String get symbol =>
      full.isEmpty ? '' : full.split(' ').take(2).map((w) => w[0]).join();
}
