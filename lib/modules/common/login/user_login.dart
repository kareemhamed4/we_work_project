import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/layout_company/layout_screen.dart';
import 'package:we_work/modules/common/choose_signup/selection_sign_up.dart';
import 'package:we_work/modules/common/forget_password/forget%20password.dart';
import 'package:we_work/modules/common/login/cubit/cubit.dart';
import 'package:we_work/modules/common/login/cubit/states.dart';
import 'package:we_work/network/local/cache_helper.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/constants/constants.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class LoginUser extends StatelessWidget {
  LoginUser({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserLoginCubit,UserLoginStates>(
      listener: (context,state){
        if(state is UserLoginSuccessState){
          if(state.userLoginModel.isCompany == false){
            CacheHelper.saveData(key: "userToken", value: state.userLoginModel.token!).then((value){
              userToken = state.userLoginModel.token!;
              NavigateToReb(context: context, widget: const LayoutScreen());
            });
          }else if(state.userLoginModel.isCompany == true){
            CacheHelper.saveData(key: "companyToken", value: state.userLoginModel.token!).then((value){
              companyToken = state.userLoginModel.token!;
              NavigateToReb(context: context, widget: const LayoutCompanyScreen());
            });
          }
        }
        if(state is UserLoginErrorState){
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context,state){
        UserLoginCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Welcome Back',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: myFavColor),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(
                      'Email',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                    ),
                    SizedBox(height: 8.h),
                    myTextFormField(
                      context: context,
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                    ),
                    SizedBox(height: 8.h),
                    myTextFormField(
                      context: context,
                      controller: passwordController,
                      type: TextInputType.text,
                      suffixIcon: IconButton(
                        icon: Icon(cubit.suffixIcon),
                        onPressed: () {
                          cubit.changeLoginSuffixIcon();
                        },
                      ),
                      hint: "● ● ● ● ● ● ● ● ●",
                      isPassword: cubit.isPassword,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8.h),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: myTextButton(
                          context: context,
                          label: "Forget Password?",
                          onPressed: () {
                            NavigateTo(context: context, widget: ForgetPassword());
                          }),
                    ),
                    SizedBox(height: 200.h),
                    ConditionalBuilder(
                      condition: state is! UserLoginLoadingState,
                      builder: (context) => myMaterialButton(
                        context: context,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.userLogin(
                              email: emailController.text,
                              password: passwordController.text
                            );
                          }
                        },
                        labelWidget: Text(
                          'Log in',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ),
                      fallback: (context) => myMaterialButton(
                        context: context,
                        onPressed: () {
                          null;
                        },
                        labelWidget: const Center(
                          child: SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium,
                        ),
                        myTextButton(
                          context: context,
                          label: "Sign up",
                          onPressed: () {
                            NavigateTo(context: context, widget: const ChooseRegister());
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 200.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
