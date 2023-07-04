import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/modules/admin_panel/cubit/admin_register_cubit.dart';
import 'package:medics/modules/admin_panel/cubit/admin_register_states.dart';
import 'package:medics/modules/login/login_screen.dart';
import 'package:medics/modules/complete_profile/cubit/user_complete_profile_cubit.dart';
import 'package:medics/modules/complete_profile/cubit/user_complete_profile_states.dart';
import 'package:medics/modules/admin_panel/admin_register_screen.dart';
import 'package:medics/shared/components.dart';
import 'package:medics/shared/constants.dart';

class AdminScreen extends StatefulWidget
{
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context){
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          'Admin Panel',
          style: TextStyle(color: Colors.white),
        )),
        body: BlocProvider(
          create: (context) => AdminRegisterCubit()..getUsedVests(),
          child: BlocConsumer<AdminRegisterCubit,AdminRegisterStates>(
            listener: (context, state) {
            },
            builder: (context, state) {
              var screenWidth=   MediaQuery.of(context).size.width;
              var screenHeight = MediaQuery.of(context).size.height;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    Container(
                      width: 200,
                      margin: EdgeInsets.symmetric(horizontal: (screenWidth/2) - 100.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(19),
                        ),
                        child: MaterialButton(
                          onPressed: () {
                            navigateTo(context, AdminRegisterScreen());
                          },
                          child: Text(
                            'Add new vest',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Used Vests',
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                    buildList(AdminRegisterCubit.get(context).usedVests,context),
                    SizedBox(height: 20,),
                    Container(
                      width: 200,
                      margin: EdgeInsets.symmetric(horizontal: (screenWidth/2) - 100.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(19),
                        ),

                        child: MaterialButton(
                          onPressed: () {
                            signOut(context);
                          },
                          child: Text(
                            'Logout',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],


                ),
              );
            }
          ),
        ),
      ),
    );
  }

  Widget buildListItem(String currentVest,context,int itemIndex){
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container (
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border:
          Border.all(width: 3, color: Colors.white70),
          borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                 width: 40,
                 height: 40,
                child: Image(
                  image: AssetImage('assets/images/vest.png'),
                )),
            SizedBox(width: 10,),
            Column(

              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                Text(
                  'Vest id',
                  style:TextStyle(fontSize: screenWidth*0.04, color: Colors.white),
                ),
                Text(
                  currentVest,
                  style:TextStyle(fontSize:  screenWidth*0.04, color: Colors.white),

                ),
              ],
            ),

            Spacer(),
            TextButton(
              onPressed: () {
                   //not implemented yet
                     AdminRegisterCubit.get(context).usedVests.removeAt(itemIndex);
                   setState(() {
                     AdminRegisterCubit.get(context).availableVests.add("$itemIndex");
                   });
              },
              child: Text(
                'Reset',
                style: TextStyle(color:
                Colors.white,fontSize: screenWidth*0.04
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {},
              child: IconButton(
                icon: Icon(Icons.edit, color: Colors.white,size: 25),
                onPressed: () {
                  navigateTo(context, AdminRegisterScreen());
                },
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget buildList(list,context)=>
      ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) =>buildListItem(list[index], context,index),
          separatorBuilder: (context, index) => myDivider(),
          itemCount: list.length,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),

      );
}
