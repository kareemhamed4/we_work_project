import 'package:flutter/material.dart';
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
                mySizedBox(size: size,myHeight: 40),
                Image.asset(
                  'assets/image/Rectangle 3.png',
                ),
                mySizedBox(size: size,myHeight: 40),
                Text(
                  'Please enter your email address to receive verification code',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 16, height: 1.5),
                ),
                mySizedBox(size: size,myHeight: 45),
                Text(
                  'Enter your email',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14),
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
                mySizedBox(size: size,myHeight: 120),
                myMaterialButton(
                  context: context,
                  onPressed: () {
                    if(formKey.currentState!.validate()){
                      NavigateTo(context: context, widget: const ConfirmMessage());
                    }
                  },
                  labelWidget: Text(
                    'Send',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                mySizedBox(size: size,myHeight: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
