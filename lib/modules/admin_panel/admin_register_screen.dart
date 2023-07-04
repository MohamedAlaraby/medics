import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/modules/admin_panel/admin_home_screen.dart';
import 'package:medics/modules/admin_panel/cubit/admin_register_cubit.dart';
import 'package:medics/modules/admin_panel/cubit/admin_register_states.dart';
import 'package:medics/modules/login/login_screen.dart';
import 'package:medics/modules/complete_profile/cubit/user_complete_profile_cubit.dart';
import 'package:medics/modules/complete_profile/cubit/user_complete_profile_states.dart';
import 'package:medics/shared/components.dart';
import 'package:medics/shared/constants.dart';
import 'package:medics/shared/network/local/cache_helper.dart';

class AdminRegisterScreen extends StatefulWidget {
  AdminRegisterScreen({Key? key}) : super(key: key);
  @override
  State<AdminRegisterScreen> createState() => _AdminRegisterScreenState();
}

class _AdminRegisterScreenState extends State<AdminRegisterScreen> {
  String? dropDownValue;

  var emailController   =TextEditingController();
  var passwordController=TextEditingController();

  var formKey     = GlobalKey<FormState>();
  //to validate on the text form field.


  DropdownMenuItem<String>  buildMenuItem(String item)=>DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style:TextStyle
        (
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          color: Colors.white
        ),
      )

  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context) => AdminRegisterCubit()..getAvailableVests(),
        child: BlocConsumer<AdminRegisterCubit,AdminRegisterStates>(
          listener: (context, state) {
            if(state is AdminRegisterSuccessState) {
              //here you can go to home screen.
              //status true.
              CacheHelper.saveData(
                  key: 'token', value: state.vestModel.token)
                  .then((value) {
                navigateAndFinish(context, AdminScreen());
                token = CacheHelper.getData(key: 'token');
                print('your token is $token');
              });
              makeToast(
                  message:"Registered successfully",
                  toastState: ToastStates.SUCCESS
              );
            }else if(state is AdminRegisterErrorState){
                  makeToast(
                      message:"network error happened",
                      toastState: ToastStates.ERROR
                  );
            }
          },
           builder: (context, state) {
            var emptyList= ["sorry there is no any available vests!"];
            var cubit=AdminRegisterCubit.get(context);
            return Scaffold(
              appBar:AppBar(),
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
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Add or update a vest',
                              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  color: Colors.white,fontSize: 25
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
                                label: 'Email Address',
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
                              isPassword: cubit.isPassword,
                              suffix:IconButton(
                                icon:Icon(cubit.suffix,color: Colors.white) ,
                                onPressed: () {
                                  cubit.changePasswordVisibility();
                                },
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            cubit.availableVests.isEmpty?Text(
                              "Sorry there is no any available vests!",
                              style: const TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ):

                            Text(
                              'Available vests',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.0),
                                    border: Border.all(color: Colors.white,width: 4),
                                ),
                                child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>
                                (
                                     items:cubit.availableVests.map(buildMenuItem).toList(),
                                     isExpanded: true,
                                     onChanged:(value) {
                                       setState(() {
                                          dropDownValue= value ;
                                       });
                                     },
                                     value:dropDownValue ,
                                     dropdownColor: const Color(0xff020230),
                                     iconSize: 40 ,
                                     icon: Icon(
                                         Icons.arrow_drop_down,
                                         color: Colors.white
                                     ),

                                ),
                              ),
                            ),

                            SizedBox(height: 20,),
                            ConditionalBuilder(
                              condition:state is! AdminRegisterLoadingState,
                              builder:(context) => DefaultButton(
                                  function:(){
                                    //validate to register the user.
                                    if(formKey.currentState!.validate()){
                                        if(dropDownValue !=null){
                                          AdminRegisterCubit.get(context).registerUser(
                                              email: emailController.text,
                                              password:passwordController.text,
                                              vest_id:dropDownValue!,
                                          );
                                        }else{
                                             makeToast(message: 'please enter the vest id', toastState: ToastStates.ERROR);
                                          }
                                    }
                                  },
                                  text: 'Add new vest'
                              ),//DefaultButton
                              fallback:(context) =>const Center(child: CircularProgressIndicator()) ,
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
