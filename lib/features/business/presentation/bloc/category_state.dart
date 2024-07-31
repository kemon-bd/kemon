part of 'category_bloc.dart';

abstract class FindBusinessesByCategoryState extends Equatable {
  final ListingType type;
  const FindBusinessesByCategoryState({
    required this.type,
  });

  @override
  List<Object> get props => [
        type,
      ];
}

class FindBusinessesByCategoryInitial extends FindBusinessesByCategoryState {
  const FindBusinessesByCategoryInitial({
    super.type = ListingType.business,
  });
}

class FindBusinessesByCategoryLoading extends FindBusinessesByCategoryState {
  const FindBusinessesByCategoryLoading({required super.type});
}

class FindBusinessesByCategoryError extends FindBusinessesByCategoryState {
  final Failure failure;

  const FindBusinessesByCategoryError({
    required this.failure,
    required super.type,
  });

  @override
  List<Object> get props => [failure, type];
}

class FindBusinessesByCategoryDone extends FindBusinessesByCategoryState {
  final List<BusinessEntity> businesses;

  const FindBusinessesByCategoryDone({
    required this.businesses,
    required super.type,
  });

  @override
  List<Object> get props => [businesses, type];
}
