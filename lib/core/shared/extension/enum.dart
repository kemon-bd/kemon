import '../shared.dart';

extension LookupsExtension on Lookups {
  String get dataKey {
    switch (this) {
      case Lookups.division:
        return 'division';
      case Lookups.district:
        return 'district';
      case Lookups.thana:
        return 'thana';
      case Lookups.profilePoints:
        return 'profilePoint';
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
      case SortBy.mostReviewed:
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
      case SortBy.mostReviewed:
        return 'Most Reviewed';
      case SortBy.highestRated:
        return 'Highest Rated';
      default:
        return 'Recommended';
    }
  }
}

extension WhatsNewTypeExtension on WhatsNewType {
  String get key {
    switch (this) {
      case WhatsNewType.bug:
        return 'bug';
      case WhatsNewType.feature:
        return 'feature';
      case WhatsNewType.ui:
        return 'ui';
      case WhatsNewType.security:
        return 'security';
      case WhatsNewType.performance:
        return 'performance';
      default:
        return '';
    }
  }

  IconData get icon {
    switch (this) {
      case WhatsNewType.bug:
        return Icons.bug_report_rounded;
      case WhatsNewType.feature:
        return Icons.fiber_new_rounded;
      case WhatsNewType.ui:
        return Icons.brush_rounded;
      case WhatsNewType.security:
        return Icons.security_rounded;
      case WhatsNewType.performance:
        return Icons.speed_rounded;
      default:
        return Icons.auto_fix_high_rounded;
    }
  }

  Color get color {
    switch (this) {
      case WhatsNewType.bug:
        return Colors.red;
      case WhatsNewType.feature:
        return Colors.teal;
      case WhatsNewType.ui:
        return Colors.blue;
      case WhatsNewType.security:
        return Colors.deepPurple;
      case WhatsNewType.performance:
        return Colors.indigoAccent;
      default:
        return Colors.brown;
    }
  }
}
