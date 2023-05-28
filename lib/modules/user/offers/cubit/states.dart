import 'package:we_work/models/user/user_get_offers_model.dart';

abstract class UserOffersStates{}
class UserOffersInitialState extends UserOffersStates {}
class UserGetOffersLoadingState extends UserOffersStates {}
class UserGetOffersSuccessState extends UserOffersStates {
  final List<UserGetOffersModel> userGetOffersModel;
  UserGetOffersSuccessState(this.userGetOffersModel);
}
class UserGetOffersErrorState extends UserOffersStates {
  final String error;
  UserGetOffersErrorState(this.error);
}

class UserDeclineOfferLoadingState extends UserOffersStates {}
class UserDeclineOfferSuccessState extends UserOffersStates {
  final String msg;
  UserDeclineOfferSuccessState(this.msg);
}
class UserDeclineOfferErrorState extends UserOffersStates {
  final String error;
  UserDeclineOfferErrorState(this.error);
}