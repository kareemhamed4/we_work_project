import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/layout_company/layout_screen.dart';
import 'package:we_work/modules/company/register/cubit/cubit.dart';
import 'package:we_work/modules/company/register/cubit/states.dart';
import 'package:we_work/modules/common/login/user_login.dart';
import 'package:we_work/network/local/cache_helper.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/constants/constants.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class SignUpCompany extends StatelessWidget {
  SignUpCompany({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController certificateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CompanyRegisterCubit, CompanyRegisterStates>(
      listener: (context, state) {
        if (state is CompanyRegisterSuccessState) {
          CacheHelper.saveData(
                  key: "companyToken", value: state.userRegisterModel.token!)
              .then((value) {
            companyToken = state.userRegisterModel.token!;
            NavigateToReb(
                context: context, widget: const LayoutCompanyScreen());
            buildSuccessToast(
                context: context,
                title: "Done",
                description: "Account Created Successfully!");
          });
        } else if (state is CompanyRegisterErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context, state) {
        CompanyRegisterCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Sign up',
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
                    mySizedBox(size: size, myHeight: 8),
                    Text(
                      'Company Name',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    mySizedBox(size: size, myHeight: 8),
                    myTextFormField(
                      context: context,
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your company name";
                        }
                        return null;
                      },
                    ),
                    mySizedBox(size: size, myHeight: 20),
                    Text(
                      'Company Email',
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
                    mySizedBox(size: size, myHeight: 20),
                    Text(
                      'Company Password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    mySizedBox(size: size, myHeight: 8),
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
                    mySizedBox(size: size, myHeight: 20),
                    Text(
                      'Confirm Password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    mySizedBox(size: size, myHeight: 8),
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
                    mySizedBox(size: size, myHeight: 20),
                    Text(
                      'Phone Number',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    mySizedBox(size: size, myHeight: 8),
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
                    mySizedBox(size: size, myHeight: 20),
                    Text(
                      'BIO',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    mySizedBox(size: size, myHeight: 8),
                    myTextFormField(
                      context: context,
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value!.length < 11) {
                          return "Please enter your BIO";
                        }
                        return null;
                      },
                    ),
                    mySizedBox(size: size, myHeight: 20),
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
                                    .bodyText2!
                                    .copyWith(fontSize: 14),
                              ),
                              mySizedBox(size: size, myHeight: 13),
                              myTextFormField(
                                context: context,
                                controller: countryController,
                                type: TextInputType.text,
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
                        mySizedBox(size: size, myWidth: 17),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'City',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(fontSize: 14),
                              ),
                              mySizedBox(size: size, myHeight: 13),
                              myTextFormField(
                                context: context,
                                controller: cityController,
                                type: TextInputType.text,
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
                    mySizedBox(size: size, myHeight: 40),
                    ConditionalBuilder(
                      condition: state is! CompanyRegisterLoadingState,
                      builder: (context) => myMaterialButton(
                        context: context,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.companyRegister(
                              name: nameController.text,
                              email: emailController.text,
                              city: cityController.text,
                              country: countryController.text,
                              password: passwordController.text,
                              confirmPassword: confirmPasswordController.text,
                              phoneNumber: phoneController.text,
                              bio: bioController.text,
                            );
                          }
                        },
                        labelWidget: Text(
                          'Sign Up',
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
                    mySizedBox(size: size, myHeight: 11),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Already have an account?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(fontSize: 14),
                        ),
                        myTextButton(
                          context: context,
                          label: "Log in",
                          onPressed: () {
                            NavigateTo(context: context, widget: LoginUser());
                          },
                        )
                      ],
                    ),
                    mySizedBox(size: size, myHeight: 30),
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
