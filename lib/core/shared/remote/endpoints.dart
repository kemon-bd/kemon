class RemoteEndpoints {
  static const String domain = 'https://kemon.com.bd';
  static const String _baseUrl = 'https://api.kemon.com.bd';

  //! business
  static Uri get listingsByCategory => Uri.parse('$_baseUrl/listing-by-category');
  static Uri get findListing => Uri.parse('$_baseUrl/business');

  //! category
  static Uri get featuredCategories => Uri.parse('$_baseUrl/featured-categories');
}
