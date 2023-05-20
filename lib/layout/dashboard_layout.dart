import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/layout/cubit/cubit.dart';
import 'package:medics/layout/cubit/states.dart';
import 'package:medics/shared/constants.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider( create: (context) => DashboardCubit()..getUserData(),

      child:BlocConsumer<DashboardCubit,DashboardStates>(
      listener: (context, state) { },
      builder:  (context, state) {
        var cubit=DashboardCubit.get(context);
        return Scaffold(
          appBar:AppBar (
            title:const Text('Medics'),
          ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              items:const [
                 BottomNavigationBarItem(icon:Icon(Icons.home),label:      'Prediction'),
                 BottomNavigationBarItem(icon:Icon(Icons.apps),label:      'Screen2'),
                 BottomNavigationBarItem(icon:Icon(Icons.favorite),label:  'Screen3'),
                 BottomNavigationBarItem(icon:Icon(Icons.settings),label:  'Settings'),
              ],
              onTap:(index) {
                cubit.changeBottom(index);
              },
              currentIndex:cubit.currentIndex,
          ),
        );
      },
    ),
    );
  }
}
