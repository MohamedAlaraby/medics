import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: content(),
    );
  }


Widget content(){
    return Container(
      child: Lottie.asset('LottieLogo1.json'),
    );
}
}
