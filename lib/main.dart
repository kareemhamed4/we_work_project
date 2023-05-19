import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/bloc_observer.dart';
import 'package:we_work/layout/cubit/cubit.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/layout_company/cubit/cubit.dart';
import 'package:we_work/modules/common/forget_password/cubit/cubit.dart';
import 'package:we_work/modules/common/new_password/cubit/cubit.dart';
import 'package:we_work/modules/common/otp/cubit/cubit.dart';
import 'package:we_work/modules/user/home/cubit/cubit.dart';
import 'package:we_work/modules/user/login/cubit/cubit.dart';
import 'package:we_work/modules/user/register/cubit/cubit.dart';
import 'package:we_work/modules/user/upload_cv/cubit/cubit.dart';
import 'package:we_work/network/local/cache_helper.dart';
import 'package:we_work/network/remote/dio_helper_advanced.dart';
import 'package:we_work/shared/constants/constants.dart';
import 'package:we_work/shared/styles/themes.dart';

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
          BlocProvider(create: (BuildContext context) => UserHomeCubit()..userGetAllJob()..userGetRemotlyJob()),
          BlocProvider(create: (BuildContext context) => UserApplyJobCubit()),
          BlocProvider(create: (BuildContext context) => LayoutCubit()),
          BlocProvider(create: (BuildContext context) => LayoutCompanyCubit()),
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
