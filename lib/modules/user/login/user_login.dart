import 'package:flutter/material.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/modules/common/forget_password/forget%20password.dart';
import 'package:we_work/shared/components/components.dart';
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
                myMaterialButton(
                  context: context,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      NavigateToReb(
                          context: context, widget: const LayoutScreen());
                    }
                  },
                  labelWidget: Text(
                    'Log in',
                    style: Theme.of(context).textTheme.button,
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
  }
}
