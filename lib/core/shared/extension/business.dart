import '../../../features/business/business.dart';

extension BusinessEntityExtension on BusinessEntity {
  String get remarks {
    if (rating > 4) {
      return "Excellent";
    } else if (rating > 3) {
      return "Good";
    } else if (rating > 2) {
      return "Fair";
    } else if (rating > 1) {
      return "Poor";
    } else {
      return "Very Poor";
    }
  }
}

extension BusinessModelExtension on BusinessModel {}
