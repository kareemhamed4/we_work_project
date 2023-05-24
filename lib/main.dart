import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/bloc_observer.dart';
import 'package:we_work/layout/cubit/cubit.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/layout_company/cubit/cubit.dart';
import 'package:we_work/modules/common/forget_password/cubit/cubit.dart';
import 'package:we_work/modules/common/login/cubit/cubit.dart';
import 'package:we_work/modules/common/new_password/cubit/cubit.dart';
import 'package:we_work/modules/common/otp/cubit/cubit.dart';
import 'package:we_work/modules/company/add_freelance_job/cubit/cubit.dart';
import 'package:we_work/modules/company/add_job/cubit/cubit.dart';
import 'package:we_work/modules/company/filter/cubit/cubit.dart';
import 'package:we_work/modules/company/home/cubit/cubit.dart';
import 'package:we_work/modules/company/notification/cubit/cubit.dart';
import 'package:we_work/modules/company/offers/cubit/cubit.dart';
import 'package:we_work/modules/company/profile/cubit/cubit.dart';
import 'package:we_work/modules/company/register/cubit/cubit.dart';
import 'package:we_work/modules/user/apply_job/cubit/cubit.dart';
import 'package:we_work/modules/user/filter/cubit/cubit.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/modules/user/notification/cubit/cubit.dart';
import 'package:we_work/modules/user/offers/cubit/cubit.dart';
import 'package:we_work/modules/user/profile/cubit/cubit.dart';
import 'package:we_work/modules/user/register/cubit/cubit.dart';
import 'package:we_work/modules/user/saved_jobs/cubit/cubit.dart';
import 'package:we_work/network/local/cache_helper.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';
import 'package:we_work/shared/styles/themes.dart';
import 'package:we_work/test/cubit/cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  userToken = CacheHelper.getData(key: 'userToken');
  companyToken = CacheHelper.getData(key: 'companyToken');
  DioHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) => UserRegisterCubit()),
          BlocProvider(create: (BuildContext context) => UserLoginCubit()),
          BlocProvider(create: (BuildContext context) => UserForgetPasswordCubit()),
          BlocProvider(create: (BuildContext context) => UserVerifyOTPCubit()),
          BlocProvider(create: (BuildContext context) => UserNewPasswordCubit()),
          BlocProvider(create: (BuildContext context) => UserHomeCubit()..userGetAllJob()..userGetAllFreelanceJobs()),
          BlocProvider(create: (BuildContext context) => UserApplyJobCubit()),
          BlocProvider(create: (BuildContext context) => UserGetAppliedJobsCubit()..userGetAppliedJobs()),
          BlocProvider(create: (BuildContext context) => UserProfileCubit()..getUserInfo()),
          BlocProvider(create: (BuildContext context) => UserOffersCubit()..userGetOffers()),
          BlocProvider(create: (BuildContext context) => UserFilterJobsCubit()),
          BlocProvider(create: (BuildContext context) => UserNotificationCubit()..userGetNotification()),
          BlocProvider(create: (BuildContext context) => LayoutCubit()),
          BlocProvider(create: (BuildContext context) => CompanyRegisterCubit()),
          BlocProvider(create: (BuildContext context) => CompanyAddJobCubit()),
          BlocProvider(create: (BuildContext context) => CompanyAddFreelanceJobCubit()),
          BlocProvider(create: (BuildContext context) => CompanyGetUsersWhoAppliedCubit()..companyGetAllUsersWhoApplied()),
          BlocProvider(create: (BuildContext context) => CompanyHomeCubit()..companyGetAllUsers()..companyGetHerJobs()),
          BlocProvider(create: (BuildContext context) => CompanyProfileCubit()..getCompanyInfo()),
          BlocProvider(create: (BuildContext context) => CompanyOffersCubit()..companyGetAllSentOffers()..companyGetAllFreelanceOffers()),
          BlocProvider(create: (BuildContext context) => LayoutCompanyCubit()),
          BlocProvider(create: (BuildContext context) => CompanyFilterUsersCubit()),
          BlocProvider(create: (BuildContext context) => CVCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          themeMode: ThemeMode.light,
          home: const LayoutScreen(),
        ),
      ),
    );
  }
}
