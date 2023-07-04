import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:medics/shared/colors.dart';

ThemeData lightTheme=ThemeData(
  fontFamily: 'Jannah',
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: HexColor('1e5975'),
  appBarTheme:  AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    titleSpacing: 20.0,
    backgroundColor: HexColor('1e5975'),
    elevation: 0.0,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor:HexColor('1e5975'),

    ),
    titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 25.0,
        fontWeight: FontWeight.bold
    ),
  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.grey,
    elevation: 20.0,
    backgroundColor: HexColor('1e5975'),
  ),
  textTheme: const TextTheme(
   bodyLarge:TextStyle(
      color: Colors.white,
      fontSize: 15.0,
      fontWeight: FontWeight.w600,
    ),
  ),
  unselectedWidgetColor:Colors.white,
  brightness: Brightness.dark,
);
