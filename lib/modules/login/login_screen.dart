
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/layout/dashboard_layout.dart';
import 'package:medics/modules/admin_panel/admin_home_screen.dart';
import 'package:medics/modules/complete_profile/user_complete_profile_screen.dart';
import 'package:medics/shared/components.dart';
import 'package:medics/shared/constants.dart';
import 'package:medics/shared/network/local/cache_helper.dart';
import 'cubit/login_cubit.dart';
import 'cubit/login_states.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>(); //to validate on the text form field.

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is LoginSuccessState) {


            CacheHelper.saveData(key: 'vest_id', value: state.userModel.user?.vestId);
            CacheHelper.saveData(key: 'token',   value: state.userModel.token).then((value) {
              token = CacheHelper.getData(key: 'token');
              vest_id = CacheHelper.getData(key: 'vest_id');
              print('your token is $token');
              print('your vest_id is $vest_id');


              if(state.userModel.user?.type == "1" ){
                //this user is admin
                navigateAndFinish(context, const AdminScreen());
              }

              else{

                var userName=state.userModel.user?.name;
                var userPhone=state.userModel.user?.phone;
                var userAge=state.userModel.user?.age;
                var userGender=state.userModel.user?.gender;

                if(userName!=null&&userPhone!=null&&userAge!=null&&userGender!=null){
                  navigateAndFinish(context, const DashboardLayout());
                }else{
                  navigateAndFinish(context,  CompleteProfileScreen());
                }

              }

            }
            );

          }
        },
        builder: (context, state) {
          var ScreenWidth=MediaQuery.of(context).size.width;
          var ScreenHeight=MediaQuery.of(context).size.height;
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Container(
                    height: ScreenHeight*0.9,
                    padding: EdgeInsets.all(10),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                      color: const Color(0xff020227),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 10.0),
                            Center(
                              child: Image(
                                image: AssetImage(
                                    'assets/images/medical_machine_app_icon.png'),
                                height: 150,
                                width: 150,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              'LOGIN',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                            Text(
                              'Login now to see your sensors readings.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.grey),
                            ),
                            const SizedBox(height: 40.0),
                            DefaultTextFormField(
                                controller: emailController,
                                textInputType: TextInputType.emailAddress,
                                validator: (string) {
                                  if (string!.isEmpty) {
                                    return 'please enter the email';
                                  }
                                  return null;
                                },
                                label: 'Email',
                                prefix: Icons.email),
                            const SizedBox(height: 16.0),
                            DefaultTextFormField(
                              controller: passwordController,
                              textInputType: TextInputType.visiblePassword,
                              validator: (string) {
                                if (string!.isEmpty) {
                                  return 'please enter the password';
                                }
                                return null;
                              },
                              label: 'Password',
                              prefix: Icons.lock,
                              isPassword: LoginCubit.get(context).isPassword,
                              suffix: IconButton(
                                padding: EdgeInsetsDirectional.symmetric(horizontal: 10),
                                icon: Icon(
                                  LoginCubit.get(context).suffix,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  LoginCubit.get(context)
                                      .changePasswordVisibility();
                                },
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            DefaultButton(
                              function: () {

                                if (formKey.currentState!.validate()) {


                                  if(emailController.text=="admin@medics.com"&&passwordController.text=="123"){
                                    //the user in admin
                                       navigateAndFinish(context, AdminScreen());
                                  }else{
                                    //normal user
                                    LoginCubit.get(context).loginUser(
                                      email:    emailController.text,
                                      password: passwordController.text,
                                    );
                                  }



                                }
                              },

                              text: 'LOGIN',
                            ), //DefaultButton

                            const SizedBox(height: 16.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
