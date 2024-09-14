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

extension SortByExtension on SortBy? {
  String get value {
    if (this == null) {
      return 'Recommended';
    }
    switch (this) {
      case SortBy.recommended:
        return 'Recommended';
      case SortBy.mostReviewd:
        return 'MostReviewed';
      case SortBy.highestRated:
        return 'HighestRated';
      default:
        return 'Recommended';
    }
  }

  String get text {
    if (this == null) {
      return 'Select one';
    }
    switch (this) {
      case SortBy.recommended:
        return 'Recommended';
      case SortBy.mostReviewd:
        return 'Most Reviewed';
      case SortBy.highestRated:
        return 'Highest Rated';
      default:
        return 'Recommended';
    }
  }
}
