import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/layout/cubit/states.dart';
import 'package:medics/models/user_model.dart';
import 'package:medics/models/users_model.dart';
import 'package:medics/modules/prediction/prediction_screen.dart';
import 'package:medics/modules/screen2/screen2.dart';
import 'package:medics/modules/settings/settings_screen.dart';
import 'package:medics/screen3/screen3.dart';
import 'package:medics/shared/constants.dart';
import 'package:medics/shared/network/endpoints.dart';
import 'package:medics/shared/network/remote/dio_helper.dart';

class DashboardCubit extends Cubit<DashboardStates>{
  DashboardCubit():super(DashboardInitialState());
  static DashboardCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
        const PredictionScreen(),
        const Screen2(),
        const Screen3(),
         SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(DashboardChangeBottomNavState());
  }

  UserModel? userModel;
  void getUserData(){
    emit(DashboardLoadingGetUserDataState());

    DioHelper.getData(
      url: SHOW,
      token: token
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(DashboardSuccessGetUserDataState());
      print('elaraby user details are:::${value.data}');


    }).catchError((error) {
      emit(DashboardErrorGetUserDataState());
      print("elaraby error when getting the user data  is ::::${error.toString()}");
    });
  }
  UsersModel? users;
  void getUsers(){
    emit(DashboardLoadingGetUserDataState());

    DioHelper.getData(
        url: SHOW_ALL,
        token: token
    ).then((value) {
      users = UsersModel.fromJson(value.data);
      emit(DashboardSuccessGetUserDataState());
      print('elaraby users are:::${value.data}');

    }).catchError((error) {
      emit(DashboardErrorGetUserDataState());
      print("elaraby error when getting the user data  is ::::${error.toString()}");
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }){
    emit(DashboardLoadingUpdateUserDataState());
    DioHelper.updateData(
      url: UPDATE,
      token:token,
      data: {
        'name':name,
        'email':email ,
        'phone':phone
      },
    ) .then((value) {
      userModel = UserModel.fromJson(value.data);

      emit(DashboardSuccessUpdateUserDataState());
      print('elaraby UpdateUser success details are:::${value.data}');
    }).catchError((error) {
      emit(DashboardErrorUpdateUserDataState());
      print("elaraby error when getting the UpdateUser data  is ::::${error.toString()}");
    });
  }

}

