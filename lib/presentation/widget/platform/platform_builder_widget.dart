import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class PlatformBuilderWidget extends StatelessWidget {
  final WidgetBuilder androidWidgetBuilder;
  final WidgetBuilder iosWidgetBuilder;

  PlatformBuilderWidget({
    @required this.androidWidgetBuilder,
    @required this.iosWidgetBuilder,
  });

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidWidgetBuilder(context);
      case TargetPlatform.iOS:
        return iosWidgetBuilder(context);
      default:
        return androidWidgetBuilder(context);
    }
  }
}
