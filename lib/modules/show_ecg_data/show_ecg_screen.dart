import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/layout/cubit/cubit.dart';
import 'package:medics/layout/cubit/states.dart';
import 'package:medics/modules/show_ecg_data/line_titles.dart';
import 'package:medics/shared/constants.dart';

class DrawECGData extends StatelessWidget {
   DrawECGData({Key? key}) : super(key: key);
  final gradientColors=
      [
      const Color(0xff23b6e6),
      const Color(0xff02d39a),
     ]
  ;
  @override
  Widget build(BuildContext context)=> BlocConsumer<DashboardCubit,DashboardStates>(
    listener: (context, state) {

    },
    builder: (context, state) {

       var cubit=DashboardCubit.get(context);
       var listString =cubit.getReadingsModel!.data!.ecg;
       listString = listString?.replaceAll('[', '').replaceAll(']', '');
       List<String>? stringValues = listString?.split(',');
       List<double>? ecgList = stringValues?.map((value) => double.parse(value.trim())).toList();
       print('list after conversion $ecgList');

      return SafeArea(

        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
            ),
            color: const Color(0xff020227),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 16),
              child: ECGGraph(ecgList!),
            ),
          ),
        ),
      );
    },
  );
}
class ECGGraph extends StatelessWidget {
   final List<double> ecgList;

   ECGGraph(this.ecgList);

   @override
   Widget build(BuildContext context) {
   return LineChart(
      LineChartData(
       lineBarsData: [
           LineChartBarData(
               spots: ecgList.asMap().entries.map((entry) {
                   return FlSpot(entry.key.toDouble(), entry.value);
              }).toList(),
               isCurved: true,
               colors: [Colors.blue],
               barWidth: 5,
               show:true,
               dotData: FlDotData(show: false),
               ),
           ],

            titlesData: FlTitlesData(
               show: true, // Hide all titles
               bottomTitles: SideTitles(
                   showTitles: true,
                 reservedSize: 30,
                 margin: 8,
                 getTextStyles:(context, value) => const TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 12,
                 ),
               ),
               leftTitles: SideTitles(
                 showTitles: true,
                 reservedSize: 38,
                 margin:8,
                 getTextStyles:(context, value) => const TextStyle(
                   fontWeight: FontWeight.bold,
                   fontSize: 12,
                 ),
               ),
               rightTitles: SideTitles(showTitles: false),
               topTitles: SideTitles(showTitles: false),

            ),
            maxY: 330,
            maxX: 150,
           lineTouchData: LineTouchData(
             enabled: true,

           ),

           ),
     swapAnimationDuration: Duration(milliseconds: 150), // Optional
     swapAnimationCurve: Curves.linear, // Optional
     );
     }
   }






