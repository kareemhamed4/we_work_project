import 'package:flutter/material.dart';
import 'package:we_work/layout_company/layout_screen.dart';
import 'package:we_work/modules/common/forget_password/forget%20password.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class CompanyLogIn extends StatelessWidget {
  CompanyLogIn({super.key});
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
                    'Email',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14),
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
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14),
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
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: size.height * 20 / size.height,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: myTextButton(
                        context: context,
                        label: "Forget Password?",
                        onPressed: () {
                          NavigateTo(
                              context: context, widget: ForgetPassword());
                        }),
                  ),
                  SizedBox(
                    height: size.height * 20 / size.height,
                  ),
                  myMaterialButton(
                    context: context,
                    onPressed: () {
                      if(formKey.currentState!.validate()){
                        NavigateToReb(context: context, widget: const LayoutCompanyScreen());
                      }
                    },
                    labelWidget: Text(
                      'Log in',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 2 / size.height,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14),
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
                ],
              ),
            ),
          ),
        ));
  }
}
