part of 'finds_bloc.dart';

abstract class FindIndustriesState extends Equatable {
  const FindIndustriesState();

  @override
  List<Object> get props => [];
}

class FindIndustriesInitial extends FindIndustriesState {
  const FindIndustriesInitial();
}

class FindIndustriesLoading extends FindIndustriesState {
  const FindIndustriesLoading();
}

class FindIndustriesError extends FindIndustriesState {
  final Failure failure;

  const FindIndustriesError({
    required this.failure,
  });

  @override
  List<Object> get props => [failure];
}

class FindIndustriesDone extends FindIndustriesState {
  final List<IndustryEntity> industries;

  const FindIndustriesDone({required this.industries});

  @override
  List<Object> get props => [industries];
}
