import '../../../../core/shared/shared.dart';
import '../../business.dart';

class BusinessRatingInsightsModel extends BusinessRatingInsightsEntity {
  const BusinessRatingInsightsModel({
    required super.five,
    required super.four,
    required super.three,
    required super.two,
    required super.one,
  });

  factory BusinessRatingInsightsModel.parse({
    required Map<String, dynamic> map,
  }) {
    return BusinessRatingInsightsModel(
      five: map['five'],
      four: map['four'],
      three: map['three'],
      two: map['two'],
      one: map['one'],
    );
  }

  @override
  List<Object?> get props => [five, four, three, two, one];
}
