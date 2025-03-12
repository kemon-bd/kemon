part of 'finds_bloc.dart';

sealed class FindIndustriesEvent extends Equatable {
  const FindIndustriesEvent();

  @override
  List<Object?> get props => [];
}

class FindIndustries extends FindIndustriesEvent {
  final String? query;
  const FindIndustries({
    this.query,
  });
  @override
  List<Object?> get props => [query];
}
