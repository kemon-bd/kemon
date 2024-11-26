class RemoteEndpoints {
  static const String domain = 'https://kemon.com.bd';
  static const String _baseUrl = 'https://api.kemon.com.bd';

  //! business
  static Uri get listingsByCategory => Uri.parse('$_baseUrl/listing-by-category');
  static Uri get findListing => Uri.parse('$_baseUrl/listing-by-urlslug');

  //! category
  static Uri get featuredCategories => Uri.parse('$_baseUrl/featured-categories');

  //! industry
  static Uri get industries => Uri.parse('$_baseUrl/categories');

  //! location
  static Uri get featuredLocations => Uri.parse('$_baseUrl/featured-locations');

  //! login
  static Uri get login => Uri.parse('$_baseUrl/token');
  static Uri get deactivateAccount => Uri.parse('$_baseUrl/deactivate-profile');

  //! registration
  static Uri get registration => Uri.parse('$_baseUrl/register');

  //! lookup
  static Uri get lookup => Uri.parse('$_baseUrl/get-lookup');

  //! profile
  static Uri get profile => Uri.parse('$_baseUrl/profile');
  static Uri get updateProfile => Uri.parse('$_baseUrl/update-profile');

  //! review
  static Uri get addReview => Uri.parse('$_baseUrl/save-review');
  static Uri get editReview => Uri.parse('$_baseUrl/edit-review');
  static Uri get deleteReview => Uri.parse('$_baseUrl/delete-review');
  static Uri get reviewDetails => Uri.parse('$_baseUrl/review-details');
  static Uri get userReviews => Uri.parse('$_baseUrl/user-reviews');
  static Uri get recentReviews => Uri.parse('$_baseUrl/recent-reviews');
  static Uri get reviewReactions => Uri.parse('$_baseUrl/review-reaction');
  static Uri get reactOnReview => Uri.parse('$_baseUrl/react');

  //! search
  static Uri get searchSuggestion => Uri.parse('$_baseUrl/search-suggestions');
  static Uri get searchResults => Uri.parse('$_baseUrl/search');

  //! sub-category
  static Uri get subCategories => Uri.parse('$_baseUrl/sub-categories');

  //! leaderboard
  static Uri get leaderboard => Uri.parse('$_baseUrl/leaderboard');
}
