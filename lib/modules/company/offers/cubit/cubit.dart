import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/models/company/company_get_freelance_offers.dart';
import 'package:we_work/models/company/company_get_sent_offers_model.dart';
import 'package:we_work/modules/company/offers/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class CompanyOffersCubit extends Cubit<CompanyOffersStates> {
  CompanyOffersCubit() : super(CompanyOffersInitialState());

  static CompanyOffersCubit get(context) => BlocProvider.of(context);

  List<CompanyGetSentOffersModel>? companyGetSentOffersModel;
  void companyGetAllSentOffers() async {
    emit(CompanyGetAllSentOffersLoadingState());
    try {
      final response = await DioHelper.getData(
        url: COMPANYGETSENTOFFERS,
        baseUrl: BASEURL,
        token: companyToken,
      );
      List<dynamic> responseList = response.data;
      companyGetSentOffersModel = responseList.map((json) {
        return CompanyGetSentOffersModel.fromJson(json);
      }).toList();
      emit(CompanyGetAllSentOffersSuccessState(companyGetSentOffersModel!));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["errors"];
          emit(CompanyGetAllSentOffersErrorState(errorMessage));
        } else {
          emit(CompanyGetAllSentOffersErrorState(error.toString()));
        }
      } else {
        emit(CompanyGetAllSentOffersErrorState(error.toString()));
      }
    }
  }

  List<CompanyGetFreelanceOffersModel>? companyGetFreelanceOffersModel;
  void companyGetAllFreelanceOffers() async {
    emit(CompanyGetAllFreelanceOffersLoadingState());
    try {
      final response = await DioHelper.getData(
        url: COMPANYGETFREELANCEOFFERS,
        baseUrl: BASEURL,
        token: companyToken,
      );
      List<dynamic> responseList = response.data;
      companyGetFreelanceOffersModel = responseList.map((json) {
        return CompanyGetFreelanceOffersModel.fromJson(json);
      }).toList();
      emit(CompanyGetAllFreelanceOffersSuccessState(companyGetFreelanceOffersModel!));
    } catch (error) {
      if (error is DioError) {
        if (error.response?.statusCode == 400) {
          final responseData = error.response?.data;
          final errorMessage = responseData["errors"];
          emit(CompanyGetAllFreelanceOffersErrorState(errorMessage));
        } else {
          emit(CompanyGetAllFreelanceOffersErrorState(error.toString()));
        }
      } else {
        emit(CompanyGetAllFreelanceOffersErrorState(error.toString()));
      }
    }
  }

  Future<void> companyDeleteSentOffer({
    required int offerId,
  }) async{
    emit(CompanyDeleteSentOfferLoadingState());
    await DioHelper.deleteData(
      url: "$COMPANYDELETESENDOFFER$offerId",
      token: companyToken,
      baseUrl: BASEURL,
    ).then((value) {
      emit(CompanyDeleteSentOfferSuccessState(value.data.toString()));
      companyGetAllSentOffers();
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 404) {
          final errorMessage = error.response?.data.toString();
          emit(CompanyDeleteSentOfferErrorState(errorMessage!));
        } else {
          // Handle other DioError cases
          emit(CompanyDeleteSentOfferErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(CompanyDeleteSentOfferErrorState('An error occurred. Please try again.'));
      }
    });
  }
}
