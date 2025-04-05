import '../shared.dart';

extension IntExtension on int {
  Color color({
    required ThemeScheme scheme,
  }) {
    switch (this) {
      case 5:
        return scheme.primary;
      case 4:
        return Colors.lightGreen;
      case 3:
        return Colors.yellow;
      case 2:
        return Colors.orange;
      case 1:
        return Colors.red;
      default:
        return scheme.backgroundPrimary;
    }
  }
}

extension IntListExtension on List<int> {}
