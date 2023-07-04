import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:medics/layout/cubit/cubit.dart';
import 'package:medics/layout/cubit/states.dart';
import 'package:medics/shared/components.dart';
import 'package:medics/shared/constants.dart';
import 'package:medics/shared/network/local/cache_helper.dart';

class DisplayReading extends StatelessWidget {
   DisplayReading({Key? key}) : super(key: key);

   Future<void> _handleRefresh(context) async {
      DashboardCubit.get(context).getAllSensorsReadings(vest_id: vest_id!);
      return await Future.delayed(Duration(seconds: 2));
   }

  @override
  Widget build(BuildContext context) {

    return  BlocConsumer<DashboardCubit,DashboardStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var cubit   = DashboardCubit .get(context);



        var pressure_H=cubit.getReadingsModel?.data?.pressH;
        var pressure_L=cubit.getReadingsModel?.data?.pressL;
        var spo=cubit.getReadingsModel?.data?.spo;
        var heart_rate=cubit.getReadingsModel?.data?.heartRate;
        var temp=cubit.getReadingsModel?.data?.temp;


        return  LiquidPullToRefresh(
          onRefresh: () => _handleRefresh(context),
          child: ListView(
            shrinkWrap: true,
            children: [Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: MediaQuery.of(context).size.height*0.9,
                width:  MediaQuery.of(context).size.height*0.9,
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  color: const Color(0xff020227),
                  child:Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text('The current sensors readings.',style: TextStyle(fontSize: 16,color: Colors.grey),),
                        Row(
                          children: [
                            Container(width: 40,height:40,child: Image(image: AssetImage('assets/images/pressure.png'),)),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pressure high',style: TextStyle(fontSize: 20,color: Colors.white),),
                                  SizedBox(height: 0,),
                                  Text('${pressure_H}',style: TextStyle(fontSize: 20,color: Colors.white),),
                                ],
                              ),
                            ),
                          ],
                        ),
                        myDivider(),
                        Row(
                          children: [
                            Container(width: 40,height:40,child: Image(image: AssetImage('assets/images/pressure.png'),)),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Pressure low',style: TextStyle(fontSize: 20,color: Colors.white),),
                                  SizedBox(height: 0,),
                                  Text('${pressure_L}',style: TextStyle(fontSize: 20,color: Colors.white),),
                                ],
                              ),
                            ),
                          ],
                        ),
                        myDivider(),

                        Row(
                          children: [
                            Container(width:40,height:40,child: Image(image: AssetImage('assets/images/spo2.jpg'),)),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('SPO2',style: TextStyle(fontSize: 20,color: Colors.white),),
                                  SizedBox(height: 0,),
                                  Text('${spo}',style: TextStyle(fontSize: 20,color: Colors.white),),
                                ],
                              ),
                            ),
                          ],
                        ),
                        myDivider(),


                        Row(
                          children: [
                            Container(width: 40,height:40,child: Image(image: AssetImage('assets/images/heart_rate.jpg'),)),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Heart Rate',style: TextStyle(fontSize: 20,color: Colors.white),),
                                  SizedBox(height: 0,),
                                  Text('${heart_rate}',style: TextStyle(fontSize: 20,color: Colors.white),),
                                ],
                              ),
                            ),
                          ],
                        ),
                        myDivider(),
                        Row(
                          children: [
                            Container(width: 40,height:40,child: Image(image: AssetImage('assets/images/temp.jpg'),)),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Temperature',style: TextStyle(fontSize: 20,color: Colors.white),),
                                  SizedBox(height: 0,),
                                  Text('${temp}\u00B0C',style: TextStyle(fontSize: 20,color: Colors.white),),
                                ],
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ) ,
                ),
              ),


            ),] ,
          ),
        );
      },

    );
  }
}
