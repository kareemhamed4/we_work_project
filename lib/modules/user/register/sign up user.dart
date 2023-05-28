import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/modules/common/login/user_login.dart';
import 'package:we_work/modules/user/register/cubit/cubit.dart';
import 'package:we_work/modules/user/register/cubit/states.dart';
import 'package:we_work/network/local/cache_helper.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/constants/constants.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class SignUpUser extends StatelessWidget {
  SignUpUser({super.key});
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController jobTypeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController experienceTypeController = TextEditingController();
  TextEditingController qualificationTypeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserRegisterCubit, UserRegisterStates>(
      listener: (context, state) {
        if (state is UserRegisterSuccessState) {
          CacheHelper.saveData(
                  key: "userToken", value: state.userRegisterModel.token!)
              .then((value) {
            userToken = state.userRegisterModel.token!;
            NavigateToReb(context: context, widget: const LayoutScreen());
            buildSuccessToast(
                context: context,
                title: "Done",
                description: "Account Created Successfully!");
          });
        }
        if (state is UserRegisterErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context, state) {
        UserRegisterCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Sign up',
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
                    SizedBox(height: 8.h),
                    Text(
                      'Name',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                    SizedBox(height: 8.h),
                    myTextFormField(
                      context: context,
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 21.h),
                    Text(
                      'Email',
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
                    SizedBox(height: 21.h),
                    Text(
                      'Password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
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
                    SizedBox(height: 21.h),
                    Text(
                      'Confirm Password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
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
                    SizedBox(height: 21.h),
                    Text(
                      'Job Type',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                    SizedBox(height: 8.h),
                    myTextFormField(
                      context: context,
                      controller: jobTypeController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your Job type";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 21.h),
                    Text(
                      'Phone Number',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                    SizedBox(height: 8.h),
                    myTextFormField(
                      context: context,
                      controller: phoneController,
                      type: TextInputType.number,
                      validate: (value) {
                        if (value!.length < 11) {
                          return "Please enter a valid phone number";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 21.h),
                    Text(
                      'Experience',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                    SizedBox(height: 8.h),
                    myTextFormField(
                      context: context,
                      controller: experienceTypeController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your experience";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 21.h),
                    Text(
                      'Qualification',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                    SizedBox(height: 8.h),
                    myTextFormField(
                      context: context,
                      controller: qualificationTypeController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your qualification";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 21.h),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Country',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium,
                              ),
                              SizedBox(height: 13.h),
                              myTextFormField(
                                context: context,
                                controller: countryController,
                                type: TextInputType.emailAddress,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your country";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 23.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'City',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium,
                              ),
                              SizedBox(height: 13.h),
                              myTextFormField(
                                context: context,
                                controller: cityController,
                                type: TextInputType.emailAddress,
                                validate: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter your city";
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 21.h),
                    ConditionalBuilder(
                      condition: state is! UserRegisterLoadingState,
                      builder: (context) => myMaterialButton(
                        context: context,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.userRegister(
                              name: nameController.text,
                              email: emailController.text,
                              city: cityController.text,
                              country: countryController.text,
                              experience: experienceTypeController.text,
                              qualification: qualificationTypeController.text,
                              password: passwordController.text,
                              confirmPassword: confirmPasswordController.text,
                              phoneNumber: phoneController.text,
                              jobType: jobTypeController.text,
                            );
                          }
                        },
                        labelWidget: Text(
                          'Sign Up',
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
                    SizedBox(height: 14.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Already have an account?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium,
                        ),
                        myTextButton(
                          context: context,
                          label: "Log in",
                          onPressed: () {
                            NavigateTo(context: context, widget: LoginUser());
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 51.h),
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
