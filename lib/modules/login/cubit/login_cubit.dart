import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/models/user_model.dart';
import 'package:medics/modules/login/cubit/login_states.dart';
import 'package:medics/shared/network/endpoints.dart';
import 'package:medics/shared/network/remote/dio_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() :super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  void loginUser({
    required String email,
    required String password
  }) {
    emit(LoginLoadingState());
    DioHelper.postData(
      url:LOGIN,
      data:{
        'email':email,
        'password':password
      },
    ).then((value){
       print(value.data);
       //take object from login model which contain all the response
       userModel=UserModel.fromJson(value.data);
       emit(LoginSuccessState(userModel!));
       print("login successfully and your name is ::${userModel?.user?.name}");

    }).catchError((error){
      emit(LoginErrorState(error.toString()));
      print("the error happened :::${error.toString()}");
    });
  }

  IconData suffix=Icons.visibility;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix=isPassword?Icons.visibility:Icons.visibility_off;
    emit(LoginChangePasswordVisibilityState());
  }


}