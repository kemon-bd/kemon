class RemoteEndpoints {
  static const String domain = 'https://kemon.com.bd';
  // static const String _baseUrl = 'http://localhost:5041';
  static const String _baseUrl = 'https://api.kemon.com.bd';

  //! performant
  static Uri get overview => Uri.parse('$_baseUrl/overview');
  static Uri get listing => Uri.parse('$_baseUrl/listing-details');
  static Uri get specificUserReviews => Uri.parse('$_baseUrl/specific-user-reviews');
  static Uri get reviewDeeplink => Uri.parse('$_baseUrl/deeplink-review');
  static Uri get categoryBasedListings => Uri.parse('$_baseUrl/category-based-listings');
  static Uri get locationBasedListings => Uri.parse('$_baseUrl/location-based-listings');
  static Uri get locationBasedIndustriesFilter => Uri.parse('$_baseUrl/filter-industries-by-location');
  static Uri get categoryBasedLocationsFilter => Uri.parse('$_baseUrl/filter-locations-by-category');
  static Uri get allIndustries => Uri.parse('$_baseUrl/all-industries');
  static Uri get categoriesByIndustry => Uri.parse('$_baseUrl/categories-by-industry');
  static Uri get allCategories => Uri.parse('$_baseUrl/all-categories');
  static Uri get subCategoriesByCategory => Uri.parse('$_baseUrl/sub-categories-by-category');
  static Uri get subCategory => Uri.parse('$_baseUrl/find-sub-category');
  static Uri get allLocations => Uri.parse('$_baseUrl/all-locations');
  static Uri get searchSuggestions => Uri.parse('$_baseUrl/optimized-search-suggestions');
  static Uri get leaderboardStanding => Uri.parse('$_baseUrl/leaderboard-standings');
  static Uri get block => Uri.parse('$_baseUrl/block');
  static Uri get unblock => Uri.parse('$_baseUrl/unblock');
  static Uri get blockList => Uri.parse('$_baseUrl/block-list');
  static Uri get flagReview => Uri.parse('$_baseUrl/flag-review');
  static Uri get reviewReactions => Uri.parse('$_baseUrl/find-review-reactions');
  static Uri get newReview => Uri.parse('$_baseUrl/new-review');
  static Uri get editReview => Uri.parse('$_baseUrl/edit-review');
  static Uri get deleteReview => Uri.parse('$_baseUrl/delete-review');
  static Uri get newListing => Uri.parse('$_baseUrl/new-listing');
  static Uri get categoryDeeplink => Uri.parse('$_baseUrl/deeplink-category');
  static Uri get locationDeeplink => Uri.parse('$_baseUrl/deeplink-location');

  //! business
  static Uri get listingsByCategory => Uri.parse('$_baseUrl/listing-by-category');
  static Uri get findListing => Uri.parse('$_baseUrl/listing-by-urlslug');
  static Uri get validateUrlSlug => Uri.parse('$_baseUrl/get-valid-urlslug');
  static Uri get addListing => Uri.parse('$_baseUrl/add-update-listing');

  //! category
  static Uri get featuredCategories => Uri.parse('$_baseUrl/featured-categories');
  static Uri get findCategory => Uri.parse('$_baseUrl/find-category');
  static Uri get categories => Uri.parse('$_baseUrl/categories');

  //! analytics
  static Uri get analytics => Uri.parse('$_baseUrl/sync-analytics');

  //! industry
  static Uri get industries => Uri.parse('$_baseUrl/industries');

  //! location
  static Uri get featuredLocations => Uri.parse('$_baseUrl/featured-locations');
  static Uri get listingsByLocation => Uri.parse('$_baseUrl/listing-by-location');

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
  static Uri get changePassword => Uri.parse('$_baseUrl/reset-password');

  //! review
  static Uri get addReview => Uri.parse('$_baseUrl/save-review');
  // static Uri get deleteReview => Uri.parse('$_baseUrl/delete-review');
  static Uri get reviewDetails => Uri.parse('$_baseUrl/review-details');
  static Uri get userReviews => Uri.parse('$_baseUrl/user-reviews');
  static Uri get recentReviews => Uri.parse('$_baseUrl/recent-reviews');
  // static Uri get reviewReactions => Uri.parse('$_baseUrl/review-reaction');
  static Uri get reactOnReview => Uri.parse('$_baseUrl/react');

  //! search
  static Uri get searchSuggestion => Uri.parse('$_baseUrl/search-suggestions');
  static Uri get searchResults => Uri.parse('$_baseUrl/search');

  //! sub-category
  static Uri get subCategories => Uri.parse('$_baseUrl/sub-categories');

  //! leaderboard
  static Uri get leaderboard => Uri.parse('$_baseUrl/leaderboard');
}
