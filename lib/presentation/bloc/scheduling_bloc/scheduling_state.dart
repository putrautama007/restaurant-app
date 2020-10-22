part of 'scheduling_bloc.dart';

abstract class SchedulingState extends Equatable {
  const SchedulingState();
}

class SchedulingInitialState extends SchedulingState {
  @override
  List<Object> get props => [];
}

class SchedulingLoadingState extends SchedulingState {
  @override
  List<Object> get props => [];
}

class SchedulingSetAlarmState extends SchedulingState {
  @override
  List<Object> get props => [];
}

class SchedulingCancelAlarmState extends SchedulingState {
  @override
  List<Object> get props => [];
}
