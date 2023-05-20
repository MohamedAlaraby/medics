import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:medics/layout/cubit/cubit.dart';
import 'package:medics/layout/cubit/states.dart';
import 'package:medics/layout/dashboard_layout.dart';
import 'package:medics/modules/login/login_screen.dart';
import 'package:medics/modules/on_boarding/on_boarding_screen.dart';
import 'package:medics/modules/prediction/prediction_screen.dart';
import 'package:medics/modules/test_resize_image/image_resize.dart';
import 'package:medics/shared/bloc_observer.dart';
import 'package:medics/shared/constants.dart';
import 'package:medics/shared/network/local/cache_helper.dart';
import 'package:medics/shared/network/remote/dio_helper.dart';
import 'package:medics/shared/themes.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();

  bool? onBoarding= CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  print("the token is :::$token");

  Widget? widget;
  if(onBoarding != null){
    //this means the user saw the on boarding screen before.
    if(token != null ){
      //this means the user logged in before and didn't make log out.
      widget =const DashboardLayout();
    }else{
      //this means the user didn't log in before or made log out.
      widget = LoginScreen();
    }
  }else{
    //this means the user didn't open the app before.
    widget = const OnBoardingScreen();
  }
  runApp( MyApp(widget));
}

class MyApp extends StatelessWidget {
   final Widget? widget;
   MyApp(this.widget);

   @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medics',
      theme: lightTheme,
      home:SplashScreen(widget),
    );
  }

}
class SplashScreen extends StatelessWidget
{
 final Widget? widget;
 const SplashScreen(this.widget);
  @override
  Widget build(BuildContext context)
  {
      return AnimatedSplashScreen
      (
        splash:Lottie.asset('assets/heart.json'),
        duration: 1800,
        nextScreen: widget!,
        splashIconSize:200,
      );
  }
}



