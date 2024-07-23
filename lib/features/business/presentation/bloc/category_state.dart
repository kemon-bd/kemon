part of 'category_bloc.dart';

abstract class BusinessesByCategoryState extends Equatable {
  const BusinessesByCategoryState();

  @override
  List<Object> get props => [];
}

class BusinessesByCategoryInitial extends BusinessesByCategoryState {
  const BusinessesByCategoryInitial();
}

class BusinessesByCategoryLoading extends BusinessesByCategoryState {
  const BusinessesByCategoryLoading();
}

class BusinessesByCategoryError extends BusinessesByCategoryState {
  final Failure failure;

  const BusinessesByCategoryError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class BusinessesByCategoryDone extends BusinessesByCategoryState {
  final List<BusinessEntity> businesses;

  const BusinessesByCategoryDone({required this.businesses});

  @override
  List<Object> get props => [businesses];
}
