part of 'overview_bloc.dart';

sealed class OverviewEvent extends Equatable {
  const OverviewEvent();

  @override
  List<Object> get props => [];
}

class FetchOverview extends OverviewEvent {
  const FetchOverview();
}