import '../../../../core/shared/shared.dart';

class BusinessRatingInsightsEntity extends Equatable {
  final int five;
  final int four;
  final int three;
  final int two;
  final int one;

  const BusinessRatingInsightsEntity({
    required this.five,
    required this.four,
    required this.three,
    required this.two,
    required this.one,
  });

  @override
  List<Object?> get props => [five, four, three, two, one];
}
