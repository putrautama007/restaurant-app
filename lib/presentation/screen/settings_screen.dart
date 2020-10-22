import 'package:flutter/material.dart';
import 'package:restaurant_app/external/custom_colors.dart';
import 'package:restaurant_app/external/custom_screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.yellow,
        title: Text(
          "Add Review",
          style: TextStyle(
              color: CustomColors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.sp),
        ),
      ),
    );
  }
}
