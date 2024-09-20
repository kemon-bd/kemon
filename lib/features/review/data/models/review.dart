import '../../../../core/shared/shared.dart';
import '../../review.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.identity,
    required super.user,
    required super.listing,
    required super.rating,
    required super.title,
    required super.description,
    required super.date,
    required super.likes,
    required super.photos,
  });

  factory ReviewModel.parse({
    required Map<String, dynamic> map,
  }) {
    try {
      assert(
        map.containsKey('guid'),
        'ReviewModel.parse: "guid" not found.',
      );
      assert(
        map['guid'] is String,
        'ReviewModel.parse: "guid" is not a String.',
      );
      final String guid = map['guid'] as String;

      assert(
        map.containsKey('user'),
        'ReviewModel.parse: "user" not found.',
      );
      assert(
        map['user'] is String,
        'ReviewModel.parse: "user" is not a String.',
      );
      final String userGuid = map['user'] as String;

      // assert(
      //   map.containsKey('urlSlug'),
      //   'ReviewModel.parse: "urlSlug" not found.',
      // );
      assert(
        map['urlSlug'] is String?,
        'ReviewModel.parse: "urlSlug" is not a String?.',
      );
      final String urlSlug = map['urlSlug'] ?? map['listingUrlslug'] ?? '';

      assert(
        map.containsKey('rating'),
        'ReviewModel.parse: "rating" not found.',
      );
      assert(
        map['rating'] is int,
        'ReviewModel.parse: "rating" is not a int.',
      );
      final int rating = map['rating'] as int;

      assert(
        map.containsKey('title'),
        'ReviewModel.parse: "title" not found.',
      );
      assert(
        map['title'] is String,
        'ReviewModel.parse: "title" is not a String.',
      );
      final String title = map['title'] as String;

      assert(
        map.containsKey('description'),
        'ReviewModel.parse: "description" not found.',
      );
      assert(
        map['description'] is String,
        'ReviewModel.parse: "description" is not a String.',
      );
      final String description = map['description'] as String;

      assert(
        map.containsKey('date'),
        'ReviewModel.parse: "date" not found.',
      );
      assert(
        map['date'] is String,
        'ReviewModel.parse: "date" is not a String.',
      );
      final String date = map['date'] as String;

      assert(
        map.containsKey('likes'),
        'ReviewModel.parse: "likes" not found.',
      );
      assert(
        map['likes'] is int,
        'ReviewModel.parse: "likes" is not a int.',
      );
      final int likes = map['likes'] as int;

      return ReviewModel(
        identity: Identity.guid(guid: guid),
        user: Identity.guid(guid: userGuid),
        listing: urlSlug,
        rating: rating,
        title: title,
        description: parse(description).body?.text,
        date: DateTime.parse(date),
        likes: likes,
        photos: map['reviewImages']
            .toString()
            .split(',')
            .map((url) => url.split('|').last)
            .where((url) => url.contains('.'))
            .toList(),
      );
    } catch (e, stackTrace) {
      throw ReviewModelParseFailure(
        message: e.toString(),
        stackTrace: stackTrace,
      );
    }
  }
}
