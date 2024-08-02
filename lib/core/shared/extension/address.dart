import '../shared.dart';

extension AddressExtension on Address {
  String get formatted {
    final String firstLine = street?.trim() ?? '';
    final String secondLine =
        '${(thana ?? '').trim().isNotEmpty ? '${thana!.trim()}, ' : ''}${(district ?? '').trim().isNotEmpty ? '${district!.trim()} ' : ''}'
            .trim();
    return '${firstLine.trim()}\n${secondLine.trim()}'.trim();
  }
}
