import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/models/user_model.dart';
import 'package:medics/modules/register/cubit/register_states.dart';
import 'package:medics/shared/network/endpoints.dart';
import 'package:medics/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() :super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;



  void registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
   }){
    emit(RegisterLoadingState());
    DioHelper.postData(
      url:REGISTER,
      data:{
         'name':name,
         'email':email,
         'password':password,
         'phone':phone,
      },
    ).then((value){
       print(value);
       //take object from Register model which contain all the response
       userModel=UserModel.fromJson(value.data);

       emit(RegisterSuccessState(userModel!));
       print("Registered successfully");
    }).catchError((error){
      print("the error happened :::${error.toString()}");
      emit(RegisterErrorState(error.toString()));
    });
  }
  IconData suffix=Icons.visibility;
  bool isPassword=true;


  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix=isPassword?Icons.visibility:Icons.visibility_off;
    emit(RegisterChangePasswordVisibilityState());
  }


}