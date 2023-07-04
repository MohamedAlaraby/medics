
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/layout/cubit/states.dart';
import 'package:medics/models/get_vests.dart';
import 'package:medics/models/oxy_flow_model.dart';
import 'package:medics/models/sensors_readings_model.dart';
import 'package:medics/models/user_model.dart';
import 'package:medics/modules/prediction/prediction_screen.dart';
import 'package:medics/modules/sensors_readings/DisplayReading.dart';
import 'package:medics/modules/settings/settings_screen.dart';
import 'package:medics/shared/constants.dart';
import 'package:medics/shared/network/endpoints.dart';
import 'package:medics/shared/network/remote/dio_helper.dart';
import '../../modules/show_ecg_data/show_ecg_screen.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';


class DashboardCubit extends Cubit<DashboardStates>{
  DashboardCubit():super(DashboardInitialState());
  static DashboardCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
         DisplayReading(),
         DrawECGData(),
         PredictionScreen(),
         SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(DashboardChangeBottomNavState());
  }

  UserModel? userModel;
  void getUserData(){
    emit(DashboardLoadingGetProfileState());

    DioHelper.getData(
        url: SHOW,
        token: token
    ).then((value) {
      userModel = UserModel.fromJson(value.data);
      emit(DashboardSuccessGetProfileState());
      print('elaraby user details are:::${value.data}');


    }).catchError((error) {
      emit(DashboardErrorGetProfileState());
      print("elaraby error when getting the user data  is :${error.toString()}");
    });
  }






  void updateProfile({
    required String name,
    required String phone,
    required String age,
    required String gender,
  }){
    emit(DashboardLoadingUpdateProfileState());
    DioHelper.postData(
      url: UPDATE,
      token:token,
      data: {
        'name':name,
        'phone':phone ,
        'age':age,
        'gender':gender,
      },
    ).then((value) {
      userModel = UserModel.fromJson(value.data);

      emit(DashboardSuccessUpdateProfileState());
      print('update User success details are:::${value.data}');
    }).catchError((error) {
      emit(DashboardErrorUpdateProfileState());
      print("error when Update User data is ${error.toString()}");
    });
  }


  SensorsReadingsModel? getReadingsModel;
  void getAllSensorsReadings({
    required String vest_id,
  }){
    emit(DashboardLoadingGetAllSensorsReadingsState());
    DioHelper.postData(
      url: SHOW_ALL_READINGS,
      token:token,
      data: {
        'vest_id':vest_id,
      },
    ) .then((value) {
      getReadingsModel = SensorsReadingsModel.fromJson(value.data);

      emit(DashboardSuccessGetAllSensorsReadingsState());
      print('get all sensors data success details are:::${value.data}');
    }).catchError((error) {
      emit(DashboardErrorGetAllSensorsReadingsState());
      print("error when Update User data is ${error.toString()}");
    });
  }
  //ai functions
  OxyFlowModel? oxyFlowModel;


  void getPredictedOxyFlow( {
      required String? heart_rate,
      required String? gender,
      required String? age,
      required String? spo2,
   } ){
    emit(DashboardLoadingPredictState());
    DioHelper.postDataPred(
      url: PREDICT,
      data: {
        "pr":heart_rate,
        "gender":gender,
        "age":age,
        "nCoV2":"1",
        "spo2":spo2,
      },
    ) .then((value) {
      oxyFlowModel = OxyFlowModel.fromJson(value.data);

      emit(DashboardSuccessPredictState());
      print('prediction success details are:::${value.data}');
    }).catchError((error) {
      emit(DashboardErrorPredictState());
      print("error when prediction is ${error.toString()}");
    });
  }



}

