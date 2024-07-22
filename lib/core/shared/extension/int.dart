import '../shared.dart';

extension IntExtension on int {
  Gender get parseAsGender {
    switch (this) {
      case 0:
        return Gender.male;
      case 1:
        return Gender.female;
      default:
        return Gender.other;
    }
  }
}
