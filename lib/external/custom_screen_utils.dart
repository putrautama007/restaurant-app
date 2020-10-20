import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomScreenUtils{
  static void initScreenUtils(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(360, 640));
  }
}