import 'package:flutter/material.dart';

class HeartRateBarChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenH=MediaQuery.of(context).size.height;
    var screenW=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Heart rate ranges')),
        body: Container(
          height: screenH*0.9,
          width: screenW*0.99,
          padding: EdgeInsets.all(16),
          child:Image.asset('assets/images/heart_rate_ranges.jpg'),
          ),
    ),

    );
  }
}




