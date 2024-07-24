import '../../../../core/shared/shared.dart';

class RatingEntity extends Equatable {
  final int total;
  final int five;
  final int four;
  final int three;
  final int two;
  final int one;

  const RatingEntity({
    required this.total,
    required this.five,
    required this.four,
    required this.three,
    required this.two,
    required this.one,
  });

  @override
  List<Object?> get props => [
        total,
        five,
        four,
        three,
        two,
        one,
      ];
}
