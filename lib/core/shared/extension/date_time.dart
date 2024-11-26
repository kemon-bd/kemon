import '../shared.dart';

extension DateTimeExtension on DateTime {
  String get duration {
    final DateTime now = DateTime.now().toUtc().add(Duration(hours: 6));

    final Duration diff = now.difference(this);

    if (diff.inSeconds < 60) {
      return "${diff.inSeconds} second${diff.inSeconds > 1 ? "s" : ""} ago";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} minute${diff.inMinutes > 1 ? "s" : ""} ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hour${diff.inHours > 1 ? "s" : ""} ago";
    } else if (diff.inDays < 30) {
      return "${diff.inDays} day${diff.inDays > 1 ? "s" : ""} ago";
    } else if (diff.inDays < 365) {
      return "${diff.inDays ~/ 30} month${(diff.inDays ~/ 30) > 1 ? "s" : ""} ago";
    } else {
      return "${diff.inDays ~/ 365} year${(diff.inDays ~/ 365) > 1 ? "s" : ""} ago";
    }
  }

  String get dMMMMyyyy => DateFormat('d MMMM, yyyy').format(this);
  // ignore: non_constant_identifier_names
  String get Mdyy => DateFormat('M/d/yy').format(this);
  // ignore: non_constant_identifier_names
  String get MMddyyyy => DateFormat('MM/dd/yyyy').format(this);
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

  DateTime get startOfThisYear => DateTime(DateTime.now().year - 1, 1, 1, 1).startOfTheDay;
  DateTime get endOfThisYear => DateTime(DateTime.now().year + 1, 1, 1)
      .subtract(
        const Duration(days: 1),
      )
      .endOfTheDay;
      
  DateTime get tomorrow => DateTime.now().add(const Duration(days: 1));
}
