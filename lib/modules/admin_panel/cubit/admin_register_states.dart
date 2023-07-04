import 'package:medics/models/vest_model.dart';

import '../../../models/user_model.dart';




abstract class AdminRegisterStates{}
class AdminRegisterInitialState extends AdminRegisterStates{}
class AdminRegisterLoadingState extends AdminRegisterStates{}
class AdminRegisterSuccessState extends AdminRegisterStates{
  final  VestModel vestModel;
  AdminRegisterSuccessState(this.vestModel);
}
class AdminRegisterErrorState extends AdminRegisterStates{
  final String error;
  AdminRegisterErrorState(this.error);
}
class AdminRegisterChangePasswordVisibilityState extends AdminRegisterStates{}



class AdminPanelLoadingGetAvailableVestsState extends AdminRegisterStates{}
class AdminPanelSuccessGetAvailableVestsState extends AdminRegisterStates{}
class AdminPanelErrorGetAvailableVestsState   extends   AdminRegisterStates{}

class AdminPanelLoadingGetVestsState extends AdminRegisterStates{}
class AdminPanelSuccessGetVestsState extends AdminRegisterStates{}
class AdminPanelErrorGetVestsState   extends   AdminRegisterStates{}