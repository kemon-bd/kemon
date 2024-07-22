class RemoteEndpoints {
  static const String domain = 'https://kemon.com.bd';
  static const String _baseUrl = 'https://api.kemon.com.bd';
  static Uri get authentication => Uri.parse('$_baseUrl/token');
  static Uri get forgotPassword => Uri.parse('$_baseUrl/token');
  static Uri get profile => Uri.parse('$_baseUrl/profile');
  static Uri get listings => Uri.parse('$_baseUrl/listing-by-category');
}
