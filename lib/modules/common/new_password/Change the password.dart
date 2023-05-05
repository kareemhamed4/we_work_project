import 'package:flutter/material.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
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
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: size.height * 15 / size.height,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/Rectangle 3 (2).png',
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'Please enter anew password must be different from previously password',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 16, height: 1.5),
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
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
                myMaterialButton(
                  context: context,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      NavigateToReb(
                        context: context,
                        widget: const LayoutScreen(),
                      );
                    }
                  },
                  labelWidget: Text(
                    'Verify',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
