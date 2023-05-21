import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    Size size = MediaQuery.of(context).size;
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
                  .headline5!
                  .copyWith(color: myFavColor, fontSize: 20),
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
                    mySizedBox(size: size, myHeight: 40),
                    Image.asset(
                      'assets/image/Rectangle 3.png',
                    ),
                    mySizedBox(size: size, myHeight: 40),
                    Text(
                      'Please enter your email address to receive verification code',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 16, height: 1.5),
                    ),
                    mySizedBox(size: size, myHeight: 45),
                    Text(
                      'Enter your email',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    mySizedBox(size: size, myHeight: 8),
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
                    mySizedBox(size: size, myHeight: 120),
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
                    mySizedBox(size: size, myHeight: 40),
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
