import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/modules/common/new_password/cubit/cubit.dart';
import 'package:we_work/modules/common/new_password/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class ChangePassword extends StatelessWidget {
  ChangePassword({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserNewPasswordCubit,UserNewPasswordStates>(
      listener: (context,state){
        if (state is UserNewPasswordSuccessState) {
          NavigateTo(context: context, widget: const LayoutScreen());
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    mySizedBox(size: size,myHeight: 10),
                    Image.asset(
                      'assets/image/Rectangle 3 (2).png',
                      fit: BoxFit.cover,
                    ),
                    mySizedBox(size: size,myHeight: 20),
                    Text(
                      'Please enter anew password must be different from previously password',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(fontSize: 16, height: 1.5),
                    ),
                    mySizedBox(size: size,myHeight: 20),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Enter your email',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 14),
                      ),
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
                    mySizedBox(size: size,myHeight: 20),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Enter your new password',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 14),
                      ),
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
                        if (value!.length < 8) {
                          return "password shouldn't be less than 8 characters";
                        }
                        return null;
                      },
                    ),
                    mySizedBox(size: size,myHeight: 20),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        'Confirm your new password',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(fontSize: 14),
                      ),
                    ),
                    mySizedBox(size: size,myHeight: 8),
                    myTextFormField(
                      context: context,
                      controller: confirmPasswordController,
                      type: TextInputType.text,
                      suffixIcon: const Icon(Icons.visibility_off_outlined),
                      hint: "● ● ● ● ● ● ● ● ●",
                      isPassword: true,
                      validate: (value) {
                        if (value != passwordController.text) {
                          return "password must be matched";
                        }
                        return null;
                      },
                    ),
                    mySizedBox(size: size,myHeight: 20),
                    ConditionalBuilder(
                      condition: state is! UserNewPasswordLoadingState,
                      builder: (context) => myMaterialButton(
                        context: context,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.userNewPassword(
                              email: emailController.text,
                              password: passwordController.text,
                              confirmPassword: confirmPasswordController.text,
                            );
                          }
                        },
                        labelWidget: Text(
                          'Verify',
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
                    mySizedBox(size: size,myHeight: 20),
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
