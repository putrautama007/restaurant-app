import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/external/background_service.dart';
import 'package:restaurant_app/external/date_helper.dart';
import 'package:restaurant_app/external/restaurant_shared_preferences.dart';

part 'scheduling_event.dart';

part 'scheduling_state.dart';

class SchedulingBloc extends Bloc<SchedulingEvent, SchedulingState> {
  RestaurantSharePreferences restaurantSharePreferences;

  SchedulingBloc({@required this.restaurantSharePreferences})
      : super(SchedulingInitialState());

  @override
  Stream<SchedulingState> mapEventToState(SchedulingEvent event) async* {
    if (event is CheckScheduling) {
      yield SchedulingLoadingState();
      bool value = await restaurantSharePreferences.getAlarmValue();
      if (value == true) {
        yield SchedulingSetAlarmState();
      } else {
        yield SchedulingCancelAlarmState();
      }
    } else if (event is SetScheduling) {
      yield SchedulingLoadingState();
      await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateHelper.format(),
        exact: true,
        wakeup: true,
      );
      await restaurantSharePreferences.saveAlarm(true);
      yield SchedulingSetAlarmState();
    } else if (event is CancelScheduling) {
      yield SchedulingLoadingState();
      await AndroidAlarmManager.cancel(1);
      await restaurantSharePreferences.saveAlarm(false);
      yield SchedulingCancelAlarmState();
    }
  }
}
