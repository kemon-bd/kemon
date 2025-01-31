part of 'districts_bloc.dart';

abstract class DistrictsEvent extends Equatable {
  const DistrictsEvent();

  @override
  List<Object> get props => [];
}

class FindDistricts extends DistrictsEvent {
  final String division;
  const FindDistricts({
    required this.division,
  });

  @override
  List<Object> get props => [division];
}