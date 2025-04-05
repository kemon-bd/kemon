import '../shared.dart';

extension DoubleExtension on double {
  Color color({
    required ThemeScheme scheme,
  }) {
    if (this == 5) {
      return scheme.primary;
    } else if (this >= 4.0) {
      return Colors.lightGreen;
    } else if (this >= 3.0) {
      return Colors.yellow;
    } else if (this >= 2.0) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
