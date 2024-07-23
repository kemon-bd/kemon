part of 'find_bloc.dart';

abstract class FindIndustryState extends Equatable {
  const FindIndustryState();

  @override
  List<Object> get props => [];
}

class FindIndustryInitial extends FindIndustryState {
  const FindIndustryInitial();
}

class FindIndustryLoading extends FindIndustryState {
  const FindIndustryLoading();
}

class FindIndustryError extends FindIndustryState {
  final Failure failure;

  const FindIndustryError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindIndustryDone extends FindIndustryState {
  final List<IndustryEntity> industries;

  const FindIndustryDone({required this.industries});

  @override
  List<Object> get props => [industries];
}
