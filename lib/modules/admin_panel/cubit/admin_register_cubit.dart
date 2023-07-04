import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/models/get_vests.dart';
import 'package:medics/models/user_model.dart';
import 'package:medics/models/vest_model.dart';
import 'package:medics/modules/admin_panel/cubit/admin_register_states.dart';
import 'package:medics/modules/complete_profile/cubit/user_complete_profile_states.dart';
import 'package:medics/shared/components.dart';
import 'package:medics/shared/constants.dart';
import 'package:medics/shared/network/endpoints.dart';
import 'package:medics/shared/network/remote/dio_helper.dart';

class AdminRegisterCubit extends Cubit<AdminRegisterStates> {
  AdminRegisterCubit() :super(AdminRegisterInitialState());

  static AdminRegisterCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  List<String> availableVests=[];
  List<String> usedVests     =[];


  VestModel? vestModel;
  void registerUser({
    required String email,
    required String password,
    required String vest_id
  }){
    emit(AdminRegisterLoadingState());
    DioHelper.postData(
      url:REGISTER,
      data:{
        'email':email,
        'password':password,
        'vest_id':vest_id
      },
    ).then((value){
      print(value);
      //take object from Register model which contain all the response
      vestModel=VestModel.fromJson(value.data);
      print("The vest token is ${vestModel!.token}");

      emit(AdminRegisterSuccessState(vestModel!));
      makeToast(message: 'vest added successfully', toastState:ToastStates.SUCCESS);
      print("The Vest Registered successfully");
    }).catchError((error){
      print("the error happened :::${error.toString()}");
      makeToast(message: error.toString(), toastState:ToastStates.SUCCESS);
      emit(AdminRegisterErrorState(error.toString()));
    });
  }
  GetVestsModel? getAllVestsModel;
  GetVestsModel? getAvailableVestsModel;
  GetVestsModel? getReservedVestsModel;
  void getVests(){
    emit(AdminPanelLoadingGetVestsState());

    DioHelper.getData(
        url: ALL_VESTS,
        token: token
    ).then((value) {
      getAllVestsModel = GetVestsModel.fromJson(value.data);
      emit(AdminPanelSuccessGetVestsState());
      print('elaraby get vests success :::${value.data}');


    }).catchError((error) {
      emit(AdminPanelErrorGetVestsState());
      print("elaraby error when getting the vests  is ::::${error.toString()}");
    });
  }
  void getAvailableVests(){

    emit(AdminPanelLoadingGetAvailableVestsState());


    DioHelper.getData(
        url: AVAILABLE_VESTS,
        token: token
    ).then((value) {
      getAvailableVestsModel = GetVestsModel.fromJson(value.data);
      if(getAvailableVestsModel!.code==200){
        getAvailableVestsModel?.data!.forEach((element) {

          availableVests.add((int.parse(element)+1).toString());
        }
        );
        print(availableVests);

      }
      if(availableVests.isEmpty){

        availableVests.add("4");
      }
      emit(AdminPanelSuccessGetAvailableVestsState());
      print('elaraby get available vests success :::${value.data}');
      print("availableVests.length is ${availableVests.length}");
      print("usedVests.length is ${usedVests.length}");

    }).catchError((error) {
      emit(AdminPanelErrorGetAvailableVestsState());
      print("elaraby error when getting the  available vests is ::::${error.toString()}");
    });
  }
  void getUsedVests(){
    emit(AdminPanelLoadingGetVestsState());

    DioHelper.getData(
        url: RESERVED_VESTS,
        token: token
    ).then((value) {
      getReservedVestsModel = GetVestsModel.fromJson(value.data);
      if(getReservedVestsModel!.code==200){
        getReservedVestsModel?.data!.forEach((element) {
          usedVests.add((int.parse(element)+1).toString());
        }
        );
        print(usedVests);

      }
      emit(AdminPanelSuccessGetVestsState());
      print('elaraby get reserved vests success :::${value.data}');


    }).catchError((error) {
      emit(AdminPanelErrorGetVestsState());
      print("elaraby error when getting the reserved vests  is ::::${error.toString()}");
    });
  }
  IconData suffix=Icons.visibility;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword = !isPassword;
    suffix=isPassword?Icons.visibility:Icons.visibility_off;
    emit(AdminRegisterChangePasswordVisibilityState());
  }
}