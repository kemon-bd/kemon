import '../shared.dart';

extension LookupsExtension on Lookups {
  String get dataKey {
    switch (this) {
      case Lookups.none:
        return '';
      default:
        return '';
    }
  }
}

extension GenderExtension on Gender {
  String get text {
    switch (this) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.other:
        return 'Other';
      default:
        return '';
    }
  }
}
