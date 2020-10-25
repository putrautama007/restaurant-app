part of 'scheduling_bloc.dart';

abstract class SchedulingEvent extends Equatable {
  const SchedulingEvent();
}

class CheckScheduling extends SchedulingEvent {
  @override
  List<Object> get props => [];
}

class SetScheduling extends SchedulingEvent {
  @override
  List<Object> get props => [];
}

class CancelScheduling extends SchedulingEvent {
  @override
  List<Object> get props => [];
}
