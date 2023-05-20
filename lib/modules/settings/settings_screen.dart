import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/layout/cubit/cubit.dart';
import 'package:medics/layout/cubit/states.dart';
import 'package:medics/models/user_model.dart';
import 'package:medics/shared/constants.dart';
import '../../shared/components.dart';

class SettingsScreen extends StatelessWidget {
  UserModel? userModel;

  SettingsScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardCubit, DashboardStates>(
      listener: (context, state) {},
      builder: (context, state) {
        //this builder is calling when i emit any state
        var cubit = DashboardCubit.get(context);
        nameController.text = cubit.userModel!.user!.name!;
        emailController.text = cubit.userModel!.user!.email!;
        phoneController.text = cubit.userModel!.user!.phone!;


        return ConditionalBuilder(
          condition: cubit.userModel != null,
          fallback: (context) =>const Center(child: CircularProgressIndicator()),
          builder:  (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  if(state is DashboardLoadingUpdateUserDataState)
                      const LinearProgressIndicator(),
                  const SizedBox(
                    height: 20,
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
                    height: 10,
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
                  ),
                  const SizedBox(
                    height: 10,
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
                    height: 10,
                  ),


                  DefaultButton(
                      function: () {
                        if(formKey.currentState!.validate()){
                          cubit.updateUserData(
                            name: nameController.text.toString(),
                            email: emailController.text.toString(),
                            phone: phoneController.text.toString(),
                          );
                        }
                      },
                      text: 'UPDATE'
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultButton(
                      function:(){
                        signOut(context);
                      },
                      text: 'LOGOUT'
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
