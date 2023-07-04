import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medics/models/user_model.dart';
import 'package:medics/models/vest_model.dart';
import 'package:medics/modules/complete_profile/cubit/user_complete_profile_states.dart';
import 'package:medics/shared/components.dart';
import 'package:medics/shared/constants.dart';
import 'package:medics/shared/network/endpoints.dart';
import 'package:medics/shared/network/remote/dio_helper.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileStates> {


  CompleteProfileCubit() :super(CompleteProfileInitialState());

  static CompleteProfileCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  List<String> availableVests=[
                              '2',
                              '3'
  ];
  List<String> usedVests     =['1'];
 updateProfile({
  required String name,
  required String phone,
  required String age,
  required String gender,
}){
  emit(CompleteProfileLoadingState());
  DioHelper.postData(
    url: UPDATE,
    token:token,
    data: {
      'name':name,
      'phone':phone ,
      'age':age,
      'gender':gender,
    },
  ) .then((value) {
    userModel = UserModel.fromJson(value.data);

    emit(CompleteProfileSuccessState(userModel!));
    print('complete User success details are:::${value.data}');
  }).catchError((error) {
    emit(CompleteProfileErrorState(error));
    print("error when getting the Update User data is ${error.toString()}");
  });
}


}