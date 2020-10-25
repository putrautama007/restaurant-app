import 'package:shared_preferences/shared_preferences.dart';

abstract class RestaurantSharePreferences {
  saveAlarm(bool value);

  Future<bool> getAlarmValue();
}

class RestaurantSharePreferencesImpl extends RestaurantSharePreferences {
  @override
  Future<bool> getAlarmValue() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool('alarm');
  }

  @override
  saveAlarm(bool value) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool('alarm', value);
  }
}
