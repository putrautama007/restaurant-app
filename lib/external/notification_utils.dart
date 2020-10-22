import 'dart:convert';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/data/remote/model/list_restaurant_model.dart';
import 'package:restaurant_app/domain/entity/restaurant_entity.dart';
import 'package:rxdart/rxdart.dart';

import 'navigation.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationUtils {
  static NotificationUtils _instance;

  NotificationUtils._internal() {
    _instance = this;
  }

  factory NotificationUtils() => _instance ?? NotificationUtils._internal();
  int randomIndex = Random().nextInt(20);

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      selectNotificationSubject.add(payload);
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      RestaurantListEntity restaurantListEntity) async {
    var _channelId = "1";
    var _channelName = "restaurant_channel";
    var _channelDescription = "restaurant app channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var notificationTitle = "<b>Restaurant recommendation for you!</b>";
    var restaurantName = restaurantListEntity.restaurants[randomIndex].name;

    await flutterLocalNotificationsPlugin.show(
        0, notificationTitle, restaurantName, platformChannelSpecifics,
        payload: json.encode(restaurantListEntity.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantListModel.fromJson(json.decode(payload));
        var restaurant = data.restaurants[randomIndex];
        CustomNavigator.pushNamed(route, arguments: restaurant);
      },
    );
  }
}
