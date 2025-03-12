part of 'category_bloc.dart';

abstract class FindBusinessesByCategoryState extends Equatable {
  const FindBusinessesByCategoryState();

  @override
  List<Object?> get props => [];
}

class FindBusinessesByCategoryInitial extends FindBusinessesByCategoryState {
  const FindBusinessesByCategoryInitial() ;
}

class FindBusinessesByCategoryLoading extends FindBusinessesByCategoryState {
  const FindBusinessesByCategoryLoading();
}

class FindBusinessesByCategoryError extends FindBusinessesByCategoryState {
  final Failure failure;

  const FindBusinessesByCategoryError({
    required this.failure,
  });

  @override
  List<Object?> get props => [failure];
}

class FindBusinessesByCategoryDone extends FindBusinessesByCategoryState {
  final List<BusinessLiteEntity> businesses;

  const FindBusinessesByCategoryDone({
    required this.businesses,
  });

  @override
  List<Object?> get props => [businesses];
}
