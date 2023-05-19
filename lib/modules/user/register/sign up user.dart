import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/modules/user/login/user_login.dart';
import 'package:we_work/modules/user/register/cubit/cubit.dart';
import 'package:we_work/modules/user/register/cubit/states.dart';
import 'package:we_work/network/local/cache_helper.dart';
import 'package:we_work/shared/components/components.dart';
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
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserRegisterCubit,UserRegisterStates>(
      listener: (context,state){
        if(state is UserRegisterSuccessState){
          CacheHelper.saveData(key: "userToken", value: state.userRegisterModel.token!).then((value){
            NavigateToReb(context: context, widget: const LayoutScreen());
            buildSuccessToast(
                context: context,
                title: "Done",
                description: "Account Created Successfully!");
          });
        }
        if(state is UserRegisterErrorState){
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context,state){
        UserRegisterCubit cubit = BlocProvider.of(context);
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
                    mySizedBox(size: size,myHeight: 8),
                    Text(
                      'Name',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    mySizedBox(size: size,myHeight: 8),
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
                    mySizedBox(size: size,myHeight: 21),
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
                    mySizedBox(size: size,myHeight: 21),
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
                        if (value!.length < 8) {
                          return "password shouldn't be less than 8 characters";
                        }
                        return null;
                      },
                    ),
                    mySizedBox(size: size,myHeight: 21),
                    Text(
                      'Confirm Password',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
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
                    mySizedBox(size: size,myHeight: 21),
                    Text(
                      'Job Type',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    mySizedBox(size: size,myHeight: 8),
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
                    mySizedBox(size: size,myHeight: 21),
                    Text(
                      'Phone Number',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    mySizedBox(size: size,myHeight: 8),
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
                    mySizedBox(size: size,myHeight: 21),
                    Text(
                      'Experience',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    mySizedBox(size: size,myHeight: 8),
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
                    mySizedBox(size: size,myHeight: 21),
                    Text(
                      'Qualification',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontSize: 14),
                    ),
                    mySizedBox(size: size,myHeight: 8),
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
                    mySizedBox(size: size,myHeight: 21),
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
                              mySizedBox(size: size,myHeight: 13),
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
                        mySizedBox(size: size,myWidth: 23),
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
                              mySizedBox(size: size,myHeight: 13),
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
                    mySizedBox(size: size,myHeight: 21),
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
                    mySizedBox(size: size,myHeight: 14),
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
                        ),
                      ],
                    ),
                    mySizedBox(size: size,myHeight: 51),
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
