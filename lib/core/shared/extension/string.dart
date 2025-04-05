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

  int get version {
    final List<String> version = split(".");
    final int major = int.parse(version[0]);
    final int minor = int.parse(version[1]);
    final int patch = int.parse(version[2]);
    final int appVersion = major * 10000 + minor * 100 + patch;
    return appVersion;
  }

  WhatsNewType get toWhatsNewType {
    if (same(as: WhatsNewType.bug.key)) {
      return WhatsNewType.bug;
    } else if (same(as: WhatsNewType.feature.key)) {
      return WhatsNewType.feature;
    } else if (same(as: WhatsNewType.ui.key)) {
      return WhatsNewType.ui;
    } else if (same(as: WhatsNewType.security.key)) {
      return WhatsNewType.security;
    } else if (same(as: WhatsNewType.performance.key)) {
      return WhatsNewType.performance;
    } else {
      return WhatsNewType.ux;
    }
  }

  String get url {
    if (isEmpty) {
      return '';
    } else if (startsWith("http")) {
      return this;
    }
    return "${RemoteEndpoints.domain}$this";
  }

  bool get zero {
    if (same(as: '0') || same(as: '00') || same(as: '0.0') || same(as: '0.00')) {
      return true;
    }
    return false;
  }
}

extension NullableStringExtension on String? {
  bool same({
    required String? as,
  }) {
    if (this == null) return false;
    return this!.toLowerCase().trim() == as?.toLowerCase().trim();
  }

  bool match({
    required String? like,
  }) {
    if (this == null) return false;
    if (like == null) return false;
    return this!.toLowerCase().trim().contains(like.toLowerCase().trim());
  }

  bool begin({
    required String? by,
  }) {
    if (this == null) return false;
    if (by == null) return false;
    return this!.toLowerCase().trim().startsWith(by.toLowerCase().trim());
  }

  bool end({
    required String? by,
  }) {
    if (this == null) return false;
    if (by == null) return false;
    return this!.toLowerCase().trim().endsWith(by.toLowerCase().trim());
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

  String get urlSlug =>
      this
          ?.toLowerCase() // Convert to lowercase
          .replaceAll(RegExp(r'[^\w\s\-—]'), '') // Keep words, spaces, hyphens (-), and em dashes (—)
          .replaceAll(RegExp(r'\s+'), '-') // Replace spaces with hyphens
          .replaceAll(RegExp(r'-{2,}'), '-') // Reduce multiple consecutive hyphens to one
          .replaceAll(RegExp(r'-\s*—'), '—') // Remove hyphens before em dashes
          .replaceAll(RegExp(r'^[-—]+|[-—]+$'), '') // Remove leading/trailing hyphens and em dashes
          .trim() ??
      ''; // Trim extra spaces (optional)
}
