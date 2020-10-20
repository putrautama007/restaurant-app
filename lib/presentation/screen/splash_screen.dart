import 'package:flutter/material.dart';
import 'package:restaurant_app/external/custom_colors.dart';
import 'package:restaurant_app/external/custom_screen_utils.dart';
import 'package:restaurant_app/external/image_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return Scaffold(
      backgroundColor: CustomColors.white,
      body: Center(
        child: Image.asset(
          ImageStrings.logo,
          width: 400.w,
          height: 400.w,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
