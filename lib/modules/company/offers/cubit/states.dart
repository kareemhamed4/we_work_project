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

class CompanyDeleteFreeLanceOfferLoadingState extends CompanyOffersStates {}
class CompanyDeleteFreeLanceOfferSuccessState extends CompanyOffersStates {
  final String msg;
  CompanyDeleteFreeLanceOfferSuccessState(this.msg);
}
class CompanyDeleteFreeLanceOfferErrorState extends CompanyOffersStates {
  final String error;
  CompanyDeleteFreeLanceOfferErrorState(this.error);
}
