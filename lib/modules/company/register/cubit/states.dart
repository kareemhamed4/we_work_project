import 'package:we_work/models/user/user_register_model.dart';

abstract class CompanyRegisterStates{}
class CompanyRegisterInitialState extends CompanyRegisterStates {}
class CompanyRegisterLoadingState extends CompanyRegisterStates {}
class CompanyRegisterSuccessState extends CompanyRegisterStates {
  final UserRegisterModel userRegisterModel;
  CompanyRegisterSuccessState(this.userRegisterModel);
}
class CompanyRegisterErrorState extends CompanyRegisterStates {
  final String error;
  CompanyRegisterErrorState(this.error);
}