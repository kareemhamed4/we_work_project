import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/layout_company/layout_screen.dart';
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
    Size size = MediaQuery.of(context).size;
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
                  .headline5!
                  .copyWith(color: myFavColor, fontSize: 20),
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
                    mySizedBox(size: size,myHeight: 8),
                    Text(
                      'Email',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    mySizedBox(size: size,myHeight: 8),
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
                    mySizedBox(size: size,myHeight: 24),
                    Text(
                      'Password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    mySizedBox(size: size,myHeight: 8),
                    myTextFormField(
                      context: context,
                      controller: passwordController,
                      type: TextInputType.text,
                      suffixIcon: const Icon(Icons.visibility_off_outlined),
                      hint: "● ● ● ● ● ● ● ● ●",
                      isPassword: true,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                    ),
                    mySizedBox(size: size,myHeight: 8),
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: myTextButton(
                          context: context,
                          label: "Forget Password?",
                          onPressed: () {
                            NavigateTo(context: context, widget: ForgetPassword());
                          }),
                    ),
                    mySizedBox(size: size,myHeight: 200),
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
                          style: Theme.of(context).textTheme.button,
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
                    mySizedBox(size: size,myHeight: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 14),
                        ),
                        myTextButton(
                          context: context,
                          label: "Sign up",
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    mySizedBox(size: size,myHeight: 205),
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
