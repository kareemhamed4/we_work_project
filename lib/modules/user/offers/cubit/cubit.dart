import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/models/user/user_get_offers_model.dart';
import 'package:we_work/modules/user/offers/cubit/states.dart';
import 'package:we_work/network/end_points.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';

class UserOffersCubit extends Cubit<UserOffersStates> {
  UserOffersCubit() : super(UserOffersInitialState());

  static UserOffersCubit get(context) => BlocProvider.of(context);

  List<UserGetOffersModel>? userGetOffersModel;
  void userGetOffers() {
    emit(UserGetOffersLoadingState());
    DioHelper.getData(
      url: USERGETALLOFFERS,
      baseUrl: BASEURL,
      token: userToken,
    ).then((value){
      List<dynamic> responseList = value.data;
      userGetOffersModel = responseList.map((json) {
        return UserGetOffersModel.fromJson(json);
      }).toList();
      emit(UserGetOffersSuccessState(userGetOffersModel!));
    }).catchError((error){
      if (error is DioError) {
        if (error.response?.statusCode == 401) {
          emit(UserGetOffersErrorState("Invalid User"));
        }else{
          emit(UserGetOffersErrorState(error.toString()));
        }
    }else{
        emit(UserGetOffersErrorState(error.toString()));
      }
    });
  }

  Future<void> userDeclineOffer({
    required int offerId,
  }) async{
    emit(UserDeclineOfferLoadingState());
    await DioHelper.deleteData(
      url: "$USERDECLINEOFFER$offerId",
      token: userToken,
      baseUrl: BASEURL,
    ).then((value) {
      emit(UserDeclineOfferSuccessState("Offer Declined Successfully!"));
      userGetOffers();
    }).catchError((error) {
      if (error is DioError) {
        if (error.response?.statusCode == 404) {
          final errorResponse = error.response?.data;
          final errorMessage = errorResponse["title"];
          emit(UserDeclineOfferErrorState(errorMessage));
        } else {
          // Handle other DioError cases
          emit(UserDeclineOfferErrorState('An error occurred. Please try again.'));
        }
      } else {
        // Handle non-DioError cases
        emit(UserDeclineOfferErrorState('An error occurred. Please try again.'));
      }
    });
  }
}
