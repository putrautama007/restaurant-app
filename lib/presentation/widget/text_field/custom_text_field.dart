import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_app/external/custom_colors.dart';
import 'package:restaurant_app/external/custom_screen_utils.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final int maxLines;
  final ValueChanged<String> onFieldSubmitted;
  final FocusNode focusNode;

  CustomTextField({
    @required this.controller,
    @required this.hint,
    @required this.keyboardType,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return Container(
      decoration: BoxDecoration(
        color: CustomColors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 0.5),
            blurRadius: 1.0,
          ),
        ],
      ),
      margin: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0.w),
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        focusNode: focusNode,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: TextStyle(color: CustomColors.darkGrey),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(8.w, 0.w, 8.w, 0.w),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(color: CustomColors.grey)),
      ),
    );
  }
}
