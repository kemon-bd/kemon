import '../shared.dart';

extension DateRangeOptionEnumExtension on DateRangeOption {
  String get name {
    switch (this) {
      case DateRangeOption.today:
        return 'Today';
      case DateRangeOption.yesterday:
        return 'Yesterday';
      case DateRangeOption.thisWeek:
        return 'This week';
      case DateRangeOption.lastWeek:
        return 'Last week';
      case DateRangeOption.thisMonth:
        return 'This month';
      case DateRangeOption.lastMonth:
        return 'Last month';
      case DateRangeOption.thisYear:
        return 'This year';
      case DateRangeOption.lastYear:
        return 'Last year';
      case DateRangeOption.last30days:
        return 'Last 30 days';
      case DateRangeOption.last90days:
        return 'Last 90 days';
      case DateRangeOption.allTime:
        return 'All time';
      case DateRangeOption.custom:
        return 'Custom';
      }
  }

  DateTimeRange get evaluate {
    final DateTime now = DateTime.now();
    late final DateTime start, end;
    switch (this) {
      case DateRangeOption.today:
        start = now;
        end = now;
        break;
      case DateRangeOption.yesterday:
        start = now.subtract(const Duration(days: 1));
        end = now.subtract(const Duration(days: 1));
      case DateRangeOption.thisWeek:
        start = now.subtract(Duration(days: now.weekday - 1));
        end = now.add(Duration(days: 7 - now.weekday));
        break;
      case DateRangeOption.lastWeek:
        start = now.subtract(Duration(days: now.weekday + 6));
        end = now.subtract(Duration(days: now.weekday));
        break;
      case DateRangeOption.thisMonth:
        start = DateTime(now.year, now.month, 1);
        end = DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));
        break;
      case DateRangeOption.lastMonth:
        start = DateTime(now.year, now.month - 1, 1);
        end = DateTime(now.year, now.month, 1).subtract(const Duration(days: 1));
        break;
      case DateRangeOption.thisYear:
        start = DateTime(now.year, 1, 1);
        end = DateTime(now.year + 1, 1, 1).subtract(const Duration(days: 1));
        break;
      case DateRangeOption.lastYear:
        start = DateTime(now.year - 1, 1, 1);
        end = DateTime(now.year, 1, 1).subtract(const Duration(days: 1));
        break;
      case DateRangeOption.last30days:
        start = now.subtract(const Duration(days: 30));
        end = now;
        break;
      case DateRangeOption.last90days:
        start = now.subtract(const Duration(days: 90));
        end = now;
        break;
      case DateRangeOption.allTime:
        start = DateTime(2020, 1, 1);
        end = DateTime(2100);
        break;
      case DateRangeOption.custom:
      start = DateTime(2010, 1, 1);
        end = now;
    }

    return DateTimeRange(
      start: start.startOfTheDay,
      end: end.endOfTheDay,
    );
  }
}

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
      }
  }
}

extension AnalyticSourceExtension on AnalyticSource {
  String get dataKey {
    switch (this) {
      case AnalyticSource.socialProfile:
        return "SocialProfile";
      case AnalyticSource.phone:
        return "Phone";
      case AnalyticSource.email:
        return "Email";
      case AnalyticSource.address:
        return "Address";
      case AnalyticSource.website:
        return "Website";
    }
  }
}

extension RatingRangeExtension on RatingRange {
  List<int> get stars {
    switch (this) {
      case RatingRange.all:
        return [];
      case RatingRange.worst:
        return [0, 1, 2];
      case RatingRange.average:
        return [2, 3, 4];
      case RatingRange.best:
        return [4, 5];
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
