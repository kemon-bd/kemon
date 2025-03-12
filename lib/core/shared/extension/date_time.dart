import '../shared.dart';

extension DateTimeExtension on DateTime {
  String get duration {
    final DateTime now = DateTime.now();

    final Duration diff = now.difference(copyWith(isUtc: true));

    if (diff.inSeconds < 60) {
      return "${diff.inSeconds}s";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes}m";
    } else if (diff.inHours < 24) {
      return "${diff.inHours}h";
    } else if (diff.inDays < 30) {
      return hmmEEE;
    } else if (diff.inDays < 365) {
      return dMMM;
    } else {
      return dMMMyyyy;
    }
  }

  String get dMMMyyyy => DateFormat('d MMM, yyyy').format(this);
  String get dMMMMyyyy => DateFormat('d MMMM, yyyy').format(this);
  // ignore: non_constant_identifier_names
  String get Mdyy => DateFormat('M/d/yy').format(this);
  // ignore: non_constant_identifier_names
  String get dMMM => DateFormat('d MMM').format(this);
  // ignore: non_constant_identifier_names
  String get MMddyyyy => DateFormat('MM/dd/yyyy').format(this);
  // ignore: non_constant_identifier_names
  String get Myy => DateFormat('MMMM yy').format(this);
  // ignore: non_constant_identifier_names
  String get hmmEEE => DateFormat('h:mm a, EEE').format(this);
  String get hmm => DateFormat('h:mm a').format(this);
  String get greetings {
    final int hour = this.hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  DateTime get endOfTheDay => copyWith(
        hour: 23,
        minute: 59,
        second: 59,
      );

  DateTime get startOfTheDay => copyWith(
        hour: 0,
        minute: 0,
        second: 0,
      );

  DateTime get startOfThisYear => copyWith(month: 1, day: 1).startOfTheDay;
  DateTime get endOfThisYear => copyWith(year: DateTime.now().year + 1, month: 1, day: 1)
      .subtract(
        const Duration(days: 1),
      )
      .endOfTheDay;

  DateTime get tomorrow => DateTime.now().add(const Duration(days: 1));
}
