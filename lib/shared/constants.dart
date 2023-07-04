import 'package:medics/modules/login/login_screen.dart';
import 'package:medics/shared/components.dart';
import 'package:medics/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    navigateAndFinish(context, LoginScreen());
  });

}
void printFullText(String? text){
  final pattern=RegExp('.{1,800}');//800 size of each chunk.
  pattern.allMatches(text!).forEach((match) {
   print(match.group(0)) ;
  });

}
//to be able to get the token from any screen in the app as long as the app is alive.
String? token=' ';
String? vest_id=' ';
  // Constant Color
   const Color kPinkColor = Color(0xFFFE53BB);
   const Color kCyanColor = Color(0xFF08F7FE);
   const Color kGreenColor = Color(0xFF09FBD3);
   const Color kBlackColor = Color(0xFF19191B);
   const Color kYellowColor = Color(0xFFF2A33A);
   const Color kWhiteColor = Color(0xFFFFFFFF);
   const Color kGreyColor = Color(0xFF767680);
