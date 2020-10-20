import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/external/custom_colors.dart';
import 'package:restaurant_app/external/custom_screen_utils.dart';
import 'package:restaurant_app/external/image_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant_app/presentation/bloc/splash_bloc/splash_bloc.dart';
import 'package:restaurant_app/presentation/screen/home_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomScreenUtils.initScreenUtils(context);
    return BlocProvider(
      create: (context) => SplashBloc()..add(LoadSplashScreenEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoadedState) {
            Future.delayed(Duration(seconds: 2)).then((_) => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen())));
          }
        },
        child: BlocBuilder<SplashBloc, SplashState>(builder: (context, state) {
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
        }),
      ),
    );
  }
}
