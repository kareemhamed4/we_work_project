import 'package:we_work/models/company/company_get_freelance_offers.dart';
import 'package:we_work/models/company/company_get_sent_offers_model.dart';

abstract class CompanyOffersStates{}
class CompanyOffersInitialState extends CompanyOffersStates {}

class CompanyGetAllSentOffersLoadingState extends CompanyOffersStates {}
class CompanyGetAllSentOffersSuccessState extends CompanyOffersStates {
  final List<CompanyGetSentOffersModel> companyGetSentOffersModel;
  CompanyGetAllSentOffersSuccessState(this.companyGetSentOffersModel);
}
class CompanyGetAllSentOffersErrorState extends CompanyOffersStates {
  final String error;
  CompanyGetAllSentOffersErrorState(this.error);
}

class CompanyGetAllFreelanceOffersLoadingState extends CompanyOffersStates {}
class CompanyGetAllFreelanceOffersSuccessState extends CompanyOffersStates {
  final List<CompanyGetFreelanceOffersModel> companyGetFreelanceOffersModel;
  CompanyGetAllFreelanceOffersSuccessState(this.companyGetFreelanceOffersModel);
}
class CompanyGetAllFreelanceOffersErrorState extends CompanyOffersStates {
  final String error;
  CompanyGetAllFreelanceOffersErrorState(this.error);
}

class CompanyDeleteSentOfferLoadingState extends CompanyOffersStates {}
class CompanyDeleteSentOfferSuccessState extends CompanyOffersStates {
  final String msg;
  CompanyDeleteSentOfferSuccessState(this.msg);
}
class CompanyDeleteSentOfferErrorState extends CompanyOffersStates {
  final String error;
  CompanyDeleteSentOfferErrorState(this.error);
}

class CompanyAcceptFreeLanceOfferLoadingState extends CompanyOffersStates {}
class CompanyAcceptFreeLanceOfferSuccessState extends CompanyOffersStates {
  final String msg;
  CompanyAcceptFreeLanceOfferSuccessState(this.msg);
}
class CompanyAcceptFreeLanceOfferErrorState extends CompanyOffersStates {
  final String error;
  CompanyAcceptFreeLanceOfferErrorState(this.error);
}

class CreateMeetingLoadingState extends CompanyOffersStates {}
class CreateMeetingSuccessState extends CompanyOffersStates {
  final String meetingUrl;
  CreateMeetingSuccessState(this.meetingUrl);
}
class CreateMeetingErrorState extends CompanyOffersStates {
  final String error;
  CreateMeetingErrorState(this.error);
}
