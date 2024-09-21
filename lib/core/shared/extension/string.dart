import '../shared.dart';

extension StringExtension on String {
  TimeOfDay? get toTimeOfDay {
    if (contains(":")) {
      final List<String> time = split(':');
      if (time.length > 2) return null;
      return TimeOfDay(
        hour: int.tryParse(time[0]) ?? 0,
        minute: int.tryParse(time[1]) ?? 0,
      );
    }
    return null;
  }

  WhatsNewType get toWhatsNewType {
    if (like(text: WhatsNewType.bug.key)) {
      return WhatsNewType.bug;
    } else if (like(text: WhatsNewType.feature.key)) {
      return WhatsNewType.feature;
    } else if (like(text: WhatsNewType.ui.key)) {
      return WhatsNewType.ui;
    } else if (like(text: WhatsNewType.security.key)) {
      return WhatsNewType.security;
    } else if (like(text: WhatsNewType.performance.key)) {
      return WhatsNewType.performance;
    } else {
      return WhatsNewType.ux;
    }
  }

  String get url {
    if (startsWith("http")) return this;
    return "${RemoteEndpoints.domain}$this";
  }

  bool get zero {
    if (like(text: '0') ||
        like(text: '00') ||
        like(text: '0.0') ||
        like(text: '0.00')) return true;
    return false;
  }
}

extension NullableStringExtension on String? {
  bool like({
    required String? text,
  }) {
    if (this == null) return false;
    return this!.toLowerCase().trim() == text?.toLowerCase().trim();
  }

  bool has({
    required String? text,
  }) {
    if (this == null) return false;
    if (text == null) return false;
    return this!.toLowerCase().trim().contains(text.toLowerCase().trim());
  }

  String join({
    required String? text,
  }) {
    if (this != null && text != null) {
      return "$this$text";
    } else if (this != null) {
      return text!;
    } else {
      return this!;
    }
  }
}
