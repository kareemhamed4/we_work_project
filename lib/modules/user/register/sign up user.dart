import 'package:flutter/material.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/modules/user/login/user_login.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: size.height * 30 / size.height,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(
                  height: 8,
                ),
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
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'Email',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(
                  height: 8,
                ),
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
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'Password',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(
                  height: 8,
                ),
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
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'Confirm Password',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(
                  height: 8,
                ),
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
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'Job Type',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(
                  height: 8,
                ),
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
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'Phone Number',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(
                  height: 8,
                ),
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
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                myMaterialButton(
                  context: context,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      NavigateToReb(
                          context: context,
                          widget: const LayoutScreen());
                    }
                  },
                  labelWidget: Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Already have an account?",
                      style: Theme.of(context).textTheme.bodyText2,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
