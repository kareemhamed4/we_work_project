import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_work/modules/common/forget_password/cubit/cubit.dart';
import 'package:we_work/modules/common/forget_password/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';
import '../otp/Confirm the message.dart';

//ignore: must_be_immutable
class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});
  TextEditingController emailController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserForgetPasswordCubit, UserForgetPasswordStates>(
      listener: (context, state) {
        if (state is UserForgetPasswordSuccessState) {
          NavigateTo(context: context, widget: ConfirmMessage(email: emailController.text,));
        }
        if (state is UserForgetPasswordErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context, state) {
        UserForgetPasswordCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Forget Password',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40.h),
                    Image.asset(
                      'assets/image/Rectangle 3.png',
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      'Please enter your email address to receive verification code',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 16.sp, height: 1.5),
                    ),
                    SizedBox(height: 45.h),
                    Text(
                      'Enter your email',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
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
                    SizedBox(height: 120.h),
                    ConditionalBuilder(
                      condition: state is! UserForgetPasswordLoadingState,
                      builder: (context) => myMaterialButton(
                        context: context,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.userForgetPassword(
                              email: emailController.text,
                            );
                          }
                        },
                        labelWidget: Text(
                          'Send',
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
                    SizedBox(height: 40.h),
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
