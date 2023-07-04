import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/layout/cubit/cubit.dart';
import 'package:medics/layout/cubit/states.dart';
import 'package:medics/models/user_model.dart';
import 'package:medics/shared/constants.dart';
import '../../shared/components.dart';

class SettingsScreen extends StatefulWidget {

  SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  UserModel? userModel;

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  var ageController=TextEditingController();

  var formKey=GlobalKey<FormState>();

  String? gender;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<DashboardCubit, DashboardStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //this builder is calling when i emit any state
        var cubit = DashboardCubit.get(context);
        nameController.text = cubit. userModel!.user!.name!;
        emailController.text = cubit.userModel!.user!.email!;
        phoneController.text = cubit.userModel!.user!.phone!;
        ageController.text = cubit.userModel!.user!.age!;
        var gender = cubit.userModel!.user!.gender!;


        return ConditionalBuilder(

          condition: cubit.userModel != null,
          fallback: (context) =>const Center(child: CircularProgressIndicator()),
          builder:  (context) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                ),
                color: const Color(0xff020227),
                child: SingleChildScrollView(

                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  clipBehavior: Clip.antiAlias,
                  padding: EdgeInsets.all(16),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      if(state is DashboardLoadingUpdateProfileState)
                          const LinearProgressIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                      DefaultTextFormField(

                        controller: emailController,
                        textInputType: TextInputType.emailAddress,
                        validator: (String? string) {
                          if (string!.isEmpty) {
                            return 'the email can\'t be empty';
                          }
                          return null;
                        },
                        label: 'Email Address',
                        prefix: Icons.email,
                        isClickable: false,
                      ),

                      const SizedBox(
                        height: 16,
                      ),
                      DefaultTextFormField(
                        controller: nameController,
                        textInputType: TextInputType.name,
                        validator: (String? string) {
                          if (string!.isEmpty) {
                            return 'the name can\'t be empty';
                          }
                          return null;
                        },
                        label: 'Name',
                        prefix: Icons.person,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DefaultTextFormField(
                        controller: phoneController,
                        textInputType: TextInputType.phone,
                        validator: (String? string) {
                          if (string!.isEmpty) {
                            return 'the phone can\'t be empty';
                          }
                          return null;
                        },
                        label: 'Phone',
                        prefix: Icons.phone,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      DefaultTextFormField(
                        controller: ageController,
                        textInputType: TextInputType.number,
                        validator: (String? string) {
                          if (string!.isEmpty) {
                            return 'the age can\'t be empty';
                          }
                          return null;
                        },
                        label: 'Age',
                        prefix: Icons.person,
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        decoration: BoxDecoration(
                            border:
                            Border.all(width: 1, color: Colors.white70),
                            borderRadius: BorderRadius.circular(6)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gender',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Male    ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Radio(
                                    activeColor: Colors.white,
                                    value: "male",
                                    groupValue: gender,
                                    onChanged: (choosedGender) {
                                      setState(() {
                                        gender = choosedGender!;
                                        print(gender);
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Female',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Radio(
                                    activeColor: Colors.white,
                                    value: "female",
                                    groupValue: gender,
                                    onChanged: (choosedGender) {
                                      setState(() {
                                        gender = choosedGender!;
                                        print(gender);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 40,),
                      Row(
                        children: [
                          DefaultButton(
                              function: () {
                                if(formKey.currentState!.validate()){
                                  cubit.updateProfile(
                                    name:   nameController.text.toString(),
                                    phone:  phoneController.text.toString(),
                                    age:    ageController.text.toString(),
                                    gender: gender,
                                  );

                                }
                              },
                              text: 'UPDATE',
                              width:screenWidth*0.4,
                          ),
                          DefaultButton(
                              function:(){
                                signOut(context);
                              },
                              text: 'LOGOUT',
                             width:screenWidth*0.4,
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
