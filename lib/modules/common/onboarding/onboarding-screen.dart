import 'package:flutter/material.dart';
import 'package:we_work/modules/common/choose_signup/Selection%20sign%20up.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: size.height * 30 / size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/Rectangle 1.png',
                  fit: BoxFit.cover,
                ),
                Text(
                  'Our App',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: myFavColor),
                ),
                mySizedBox(size: size,myHeight: 39),
                Text(
                  'helps you in your online job search to find Jobs in Egypt and Middle East. Choose the right job using our online recruitment services',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 16, height: 1.5),
                ),
                mySizedBox(size: size,myHeight: 77),                myMaterialButton(
                  context: context,
                  onPressed: () {
                    NavigateTo(
                        context: context, widget: const ChooseRegister());
                  },
                  labelWidget: Text(
                    'Continue',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                mySizedBox(size: size,myHeight: 88),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: myTextButton(
                      context: context,
                      label: "SKIP",
                      onPressed: () {
                        NavigateTo(context: context, widget: ChooseRegister());
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
