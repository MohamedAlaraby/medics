import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/modules/login/login_screen.dart';
import 'package:medics/shared/bloc_observer.dart';
import 'package:medics/shared/network/local/cache_helper.dart';
import 'package:medics/shared/network/remote/dio_helper.dart';
import 'package:medics/shared/themes.dart';

import 'modules/admin_panel/admin_home_screen.dart';
import 'modules/complete_profile/user_complete_profile_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await DioHelper.init();
  await CacheHelper.init();
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
   MyApp();
   @override
   Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Medics',
        theme: lightTheme,
        home:  SplashScreen(),
       //  home:  AdminScreen(),
    );
  }

}
class SplashScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
      return AnimatedSplashScreen
      (
        splash:Image.asset('assets/images/medical_onboarding.png'),
        duration: 1800,
        nextScreen: LoginScreen(),
        splashIconSize:300,
      );
  }
}



