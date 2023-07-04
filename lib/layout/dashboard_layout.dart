import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/layout/cubit/cubit.dart';
import 'package:medics/layout/cubit/states.dart';
import 'package:medics/shared/constants.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => DashboardCubit()..getUserData()..getAllSensorsReadings(vest_id: vest_id!),
      child:BlocConsumer<DashboardCubit,DashboardStates>(
      listener: (context, state) { },
      builder:  (context, state) {

        var cubit=DashboardCubit.get(context);

        return SafeArea(
          child: Scaffold(
            appBar:AppBar (
              title:const Text('Medics',style: TextStyle(color: Colors.white)),
            ),
            body:cubit.screens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                items:const [
                   BottomNavigationBarItem(icon:Icon(Icons.home),label:  'Readings'),
                   BottomNavigationBarItem(icon:Icon(Icons.data_thresholding),label:'ECG'),
                   BottomNavigationBarItem(icon:Icon(Icons.online_prediction),label:'Prediction'),
                   BottomNavigationBarItem(icon:Icon(Icons.settings),label:  'Settings'),
                ],
                onTap:(index) {
                  cubit.changeBottom(index);
                },
                currentIndex:cubit.currentIndex,
            ),
          ),
        );
      },
    ),
    );
  }
}
