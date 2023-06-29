import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_work/modules/common/login/user_login.dart';
import 'package:we_work/modules/common/new_password/cubit/cubit.dart';
import 'package:we_work/modules/common/new_password/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class ChangePassword extends StatelessWidget {
  final String email;
  ChangePassword({super.key,required this.email});
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserNewPasswordCubit,UserNewPasswordStates>(
      listener: (context,state){
        if (state is UserNewPasswordSuccessState) {
          NavigateToReb(context: context, widget: LoginUser());
          buildSuccessToast(
            title: "Done!",
            context: context,
            description: state.msg,
          );
        }
        if (state is UserNewPasswordErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context,state){
        UserNewPasswordCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Create new password",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: myFavColor),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    Image.asset(
                      'assets/image/Rectangle 3 (2).png',
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Please enter anew password must be different from previously password',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 16.sp, height: 1.5),
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Enter your new password',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    myTextFormField(
                      context: context,
                      controller: passwordController,
                      type: TextInputType.text,
                      suffixIcon: IconButton(
                        icon: Icon(cubit.suffixIcon),
                        onPressed: () {
                          cubit.changePasswordSuffixIcon();
                        },
                      ),
                      hint: "● ● ● ● ● ● ● ● ●",
                      isPassword: cubit.isPassword,
                      validate: (value) {
                        if (value!.length < 8) {
                          return "password shouldn't be less than 8 characters";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Confirm your new password',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    myTextFormField(
                      context: context,
                      controller: confirmPasswordController,
                      type: TextInputType.text,
                      suffixIcon: IconButton(
                        icon: Icon(cubit.suffixConfirmIcon),
                        onPressed: () {
                          cubit.changeConfirmPasswordSuffixIcon();
                        },
                      ),
                      hint: "● ● ● ● ● ● ● ● ●",
                      isPassword: cubit.isConfirmPassword,
                      validate: (value) {
                        if (value != passwordController.text) {
                          return "password must be matched";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    ConditionalBuilder(
                      condition: state is! UserNewPasswordLoadingState,
                      builder: (context) => myMaterialButton(
                        context: context,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.userNewPassword(
                              email: email,
                              password: passwordController.text,
                              confirmPassword: confirmPasswordController.text,
                            );
                          }
                        },
                        labelWidget: Text(
                          'Verify',
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
                    SizedBox(height: 20.h),
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
