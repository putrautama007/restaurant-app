import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

class CustomNavigator {
  static pushNamed(String routeName, {Object arguments}) {
    navigationKey.currentState.pushNamed(routeName, arguments: arguments);
  }

  static pushNamedWithThenValue(String routeName,
      {Object arguments, Object thenValue}) {
    navigationKey.currentState
        .pushNamed(routeName, arguments: arguments)
        .then((value) => thenValue);
  }

  static pushReplacementNamed(String routeName, {Object arguments}) {
    navigationKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static pop() => navigationKey.currentState.pop();
}
