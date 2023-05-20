import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/layout/dashboard_layout.dart';
import 'package:medics/modules/register/register_screen.dart';
import 'package:medics/shared/components.dart';
import 'package:medics/shared/constants.dart';
import 'package:medics/shared/network/local/cache_helper.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class LoginScreen extends StatelessWidget {

   LoginScreen({Key? key}) : super(key: key);
   var emailController   =TextEditingController();
   var passwordController=TextEditingController();
   var formKey           = GlobalKey<FormState>();//to validate on the text form field.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (context, state) {
          if(state is LoginSuccessState) {
              CacheHelper.saveData(
                  key: 'token', value: state.userModel.token
              ).then((value){
                navigateAndFinish(context, const DashboardLayout());
                token = CacheHelper.getData(key: 'token');
                print('your token is $token');
              });
          }
          },
        builder: (context, state) => Scaffold(
          appBar:AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                      child:   Image(
                          image: AssetImage(
                           'assets/images/medical_machine_app_icon.png'
                        ),
                        height: 150,
                        width: 150,
                        ),
                    ),
                      const SizedBox(height: 30.0),
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.black
                        ),
                      ),
                      Text(
                        'Login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.grey
                        ),

                      ),
                      const SizedBox(height: 40.0),
                      DefaultTextFormField(
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          validator: (string) {
                            if(string!.isEmpty){
                              return 'please enter the email';
                            }
                            return null;
                          },
                          label: 'Email',
                          prefix: Icons.email
                      ),
                      const SizedBox(height: 16.0),
                      DefaultTextFormField(
                        controller: passwordController,
                        textInputType: TextInputType.visiblePassword,
                        validator: (string) {
                          if(string!.isEmpty){
                            return 'please enter the password';
                          }
                          return null;
                        },
                        label: 'Password',
                        prefix: Icons.lock,
                        isPassword: LoginCubit.get(context).isPassword,

                        suffix:IconButton(
                            icon:Icon(LoginCubit.get(context).suffix) ,
                            onPressed: () {
                                LoginCubit.get(context).changePasswordVisibility();
                            },
                            ),
                      ),
                      const SizedBox(height: 16.0),
                      DefaultButton(
                            function:(){
                              if(formKey.currentState!.validate()){

                                print(" DefaultButton login validation success");
                                print("you have entered this email${emailController.text}");
                                print("you have entered this password${passwordController.text}");
                                LoginCubit.get(context).loginUser(
                                  email: emailController.text,
                                  password:passwordController.text,
                                );
                               print("${LoginCubit.get(context).userModel?.user?.name}");

                              }

                            },
                            text: 'LOGIN'
                        ),//DefaultButton


                      const SizedBox(height: 16.0),
                      Row(
                        children: [
                          const Text('Don\'t have an account?'),
                          TextButton(
                            child:const Text('register') ,
                            onPressed: () {
                              navigateTo(context,RegisterScreen());
                            },
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ) ,
      ),
    );
  }
}
