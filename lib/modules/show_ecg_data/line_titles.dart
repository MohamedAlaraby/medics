

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineTitles{

 static  FlTitlesData getTitleData() {
    return  FlTitlesData(

   show: true,
   bottomTitles:SideTitles(
     showTitles: true,
     getTitles:(value) {
       if(value==1.0) return 'MAR';
       else if(value==3.0) return 'JUN';
       else if(value==5.0) return 'SEP';
       return '';
     },
     reservedSize: 22,
     margin: 4,
     getTextStyles:(context, value) => const TextStyle(
       color: Color(0xff68737d),
       fontWeight: FontWeight.bold,
       fontSize: 12,
     ),
   ),
   leftTitles:  SideTitles(
     showTitles: true,
     getTitles:(value) {
       if(value==1.0) return '10k';
       else if(value==3.0) return '30k';
       else if(value==5.0) return '50k';
       return '';
     },
     reservedSize: 35,
     margin:5,
     getTextStyles:(context, value) => const TextStyle(
       color: Color(0xff68737d),
       fontWeight: FontWeight.bold,
       fontSize: 12,
     ),
   ),


   );
 }
}