import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_work/bloc_observer.dart';
import 'package:we_work/cubit/cubit.dart';
import 'package:we_work/layout/cubit/cubit.dart';
import 'package:we_work/layout_company/cubit/cubit.dart';
import 'package:we_work/modules/common/forget_password/cubit/cubit.dart';
import 'package:we_work/modules/common/login/cubit/cubit.dart';
import 'package:we_work/modules/common/new_password/cubit/cubit.dart';
import 'package:we_work/modules/common/onboarding/onboarding-screen.dart';
import 'package:we_work/modules/common/otp/cubit/cubit.dart';
import 'package:we_work/modules/common/splash/splash_screen.dart';
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
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await CacheHelper.init();
  DioHelper.init();
  userToken = CacheHelper.getData(key: 'userToken');
  companyToken = CacheHelper.getData(key: 'companyToken');
  bool? onBoarding = CacheHelper.getData(key: "onBoarding");
  Widget widget;
  if(onBoarding != null){
    if(userToken != null){
      widget = const SplashScreen(isLoginBefore: true,isCompany: false);
    }else if(companyToken != null){
      widget = const SplashScreen(isLoginBefore: true,isCompany: true);
    } else{
      widget = const SplashScreen(isLoginBefore: false,isCompany: true);
    }
  }else {
    widget = const Onboarding();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({Key? key,required this.startWidget}) : super(key: key);

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
          BlocProvider(create: (BuildContext context) => MainCubit()),
          BlocProvider(create: (BuildContext context) => UserRegisterCubit()),
          BlocProvider(create: (BuildContext context) => UserLoginCubit()),
          BlocProvider(create: (BuildContext context) => UserForgetPasswordCubit()),
          BlocProvider(create: (BuildContext context) => UserVerifyOTPCubit()),
          BlocProvider(create: (BuildContext context) => UserNewPasswordCubit()),
          BlocProvider(create: (BuildContext context) => UserHomeCubit()..getAllJobs()..userGetAllFreelanceJobs()),
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
          BlocProvider(create: (BuildContext context) => CompanyGetUsersWhoAppliedCubit()..companyGetAllUsersWhoApplied()..companyGetAllMeetings()),
          BlocProvider(create: (BuildContext context) => CompanyHomeCubit()..companyGetAllUsers()..companyGetHerJobs()),
          BlocProvider(create: (BuildContext context) => CompanyProfileCubit()..getCompanyInfo()),
          BlocProvider(create: (BuildContext context) => CompanyOffersCubit()..companyGetAllSentOffers()..companyGetAllFreelanceOffers()),
          BlocProvider(create: (BuildContext context) => LayoutCompanyCubit()),
          BlocProvider(create: (BuildContext context) => CompanyFilterUsersCubit()),
          BlocProvider(create: (BuildContext context) => CVCubit()),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 780),
          useInheritedMediaQuery: true,
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context,child){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              themeMode: ThemeMode.light,
              home: startWidget,
            );
          }
        ),
      ),
    );
  }
}
