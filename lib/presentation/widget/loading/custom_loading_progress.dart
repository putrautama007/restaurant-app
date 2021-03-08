import 'package:flutter/material.dart';
import 'package:restaurant_app/external/custom_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoadingProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        Padding(
          padding: EdgeInsets.only(top: 16.w,left: 32.w, right: 32.w),
          child: Text(
            "Loading restaurant data please wait...",
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
