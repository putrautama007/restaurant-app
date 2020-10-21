import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/external/custom_colors.dart';
import 'package:restaurant_app/external/custom_screen_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_app/external/image_strings.dart';

class CustomErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          ImageStrings.error,
          width: 150.w,
          height: 150.w,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.w,left: 32.w, right: 32.w),
          child: Text(
            "An error occurred please try again later",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: CustomColors.yellow,
                fontSize: 20.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
