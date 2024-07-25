import '../../review.dart';

class RatingModel extends RatingEntity {
  const RatingModel({
    required super.total,
    required super.five,
    required super.four,
    required super.three,
    required super.two,
    required super.one,
  });

  factory RatingModel.parse({
    required Map<String, dynamic> map,
  }) {
    assert(
      map.containsKey('total'),
      'RatingModel.parse: "total" not found.',
    );
    assert(
      map['total'] is int,
      'RatingModel.parse: "total" is not a int.',
    );
    final int total = map['total'] as int;

    assert(
      map.containsKey('five') || map.containsKey('fivestar'),
      'RatingModel.parse: "five"/"fivestar" not found.',
    );
    assert(
      map['five'] is int || map['fivestar'] is int,
      'RatingModel.parse: "five"/"fivestar" is not a int.',
    );
    final int five = map['five'] ?? map['fivestar'];

    assert(
      map.containsKey('four') || map.containsKey('fourstar'),
      'RatingModel.parse: "four"/"fourstar" not found.',
    );
    assert(
      map['four'] is int || map['fourstar'] is int,
      'RatingModel.parse: "four"/"fourstar" is not a int.',
    );
    final int four = map['four'] ?? map['fourstar'];

    assert(
      map.containsKey('three') || map.containsKey('threestar'),
      'RatingModel.parse: "three"/"threestar" not found.',
    );
    assert(
      map['three'] is int || map['threestar'] is int,
      'RatingModel.parse: "three"/"threestar" is not a int.',
    );
    final int three = map['three'] ?? map['threestar'];

    assert(
      map.containsKey('two') ||
          map.containsKey('twotar') ||
          map.containsKey('twostar'),
      'RatingModel.parse: "two"/"twotar"/"twostar" not found.',
    );
    assert(
      map['two'] is int || map['twotar'] is int || map['twostar'] is int,
      'RatingModel.parse: "two"/"twotar"/"twostar" is not a int.',
    );
    final int two = map['two'] ?? map['twotar'] ?? map['twostar'];

    assert(
      map.containsKey('one') || map.containsKey('onestar'),
      'RatingModel.parse: "one"/"onestar" not found.',
    );
    assert(
      map['one'] is int || map['onestar'] is int,
      'RatingModel.parse: "one"/"onestar" is not a int.',
    );
    final int one = map['one'] ?? map['onestar'];

    return RatingModel(
      total: total,
      five: five,
      four: four,
      three: three,
      two: two,
      one: one,
    );
  }
}
