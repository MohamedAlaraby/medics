import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/layout/dashboard_layout.dart';
import 'package:medics/modules/complete_profile/cubit/user_complete_profile_cubit.dart';
import 'package:medics/modules/complete_profile/cubit/user_complete_profile_states.dart';
import 'package:medics/shared/components.dart';


class CompleteProfileScreen extends StatefulWidget {
  CompleteProfileScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var ageController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String? gender;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompleteProfileCubit(),
      child: BlocConsumer<CompleteProfileCubit, CompleteProfileStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          var cubit = CompleteProfileCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Complete your profile',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.white, fontSize: 25),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    color: const Color(0xff020227),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 40.0),
                          DefaultTextFormField(
                              controller: nameController,
                              textInputType: TextInputType.name,
                              validator: (string) {
                                if (string!.isEmpty) {
                                  return 'please enter your name';
                                }
                                return null;
                              },
                              label: 'Name',
                              prefix: Icons.person),
                          const SizedBox(height: 16.0),
                          DefaultTextFormField(
                            controller: phoneController,
                            textInputType: TextInputType.number,
                            validator: (string) {
                              if (string!.isEmpty) {
                                return 'please enter the phone';
                              }
                              return null;
                            },
                            label: 'Phone',
                            prefix: Icons.phone,
                          ),
                          const SizedBox(height: 16.0),
                          DefaultTextFormField(
                              controller: ageController,
                              textInputType: TextInputType.name,
                              validator: (string) {
                                if (string!.isEmpty) {
                                  return 'please enter your age';
                                }
                                return null;
                              },
                              label: 'Age',
                              prefix: Icons.person),
                          const SizedBox(height: 16.0),
                          Container(
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.white70),
                                borderRadius: BorderRadius.circular(6)),
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
                                            gender = choosedGender;
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
                                            gender = choosedGender;
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
                          SizedBox(
                            height: 20,
                          ),
                          ConditionalBuilder(
                            condition: state is! CompleteProfileLoadingState,
                            builder: (context) => DefaultButton(
                                function: () {
                                  //validate to register the user.
                                  if (formKey.currentState!.validate()) {
                                    CompleteProfileCubit.get(context).updateProfile(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      age: ageController.text,
                                      gender: gender!,
                                    );
                                    navigateAndFinish(context, DashboardLayout());
                                  }
                                },
                                text: 'Complete',
                            ), //DefaultButton
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
