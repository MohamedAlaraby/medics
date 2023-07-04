
import '../../../models/user_model.dart';



abstract class CompleteProfileStates{}
class CompleteProfileInitialState extends CompleteProfileStates{}
class CompleteProfileLoadingState extends CompleteProfileStates{}
class CompleteProfileSuccessState extends CompleteProfileStates{
  final  UserModel userModel;
  CompleteProfileSuccessState(this.userModel);
}
class CompleteProfileErrorState extends CompleteProfileStates{
  final String error;
  CompleteProfileErrorState(this.error);
}



