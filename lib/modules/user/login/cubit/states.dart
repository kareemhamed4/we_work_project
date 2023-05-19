import 'package:we_work/models/user/user_login_model.dart';

abstract class UserLoginStates{}
class UserLoginInitialState extends UserLoginStates {}
class UserLoginLoadingState extends UserLoginStates {}
class UserLoginSuccessState extends UserLoginStates {
  final UserLoginModel userLoginModel;
  UserLoginSuccessState(this.userLoginModel);
}
class UserLoginErrorState extends UserLoginStates {
  final String error;
  UserLoginErrorState(this.error);
}