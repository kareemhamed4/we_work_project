import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_work/modules/company/register/sign%20up%20company.dart';
import 'package:we_work/modules/user/register/sign%20up%20user.dart';
import 'package:we_work/shared/components/components.dart';

class ChooseRegister extends StatelessWidget {
  const ChooseRegister({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 16, vertical: size.height * 30 / size.height),
          child: Column(
            children: [
              Image.asset(
                'assets/image/undraw_Community_re_cyrm 1.png',
              ),
              SizedBox(height: 57.h),
              myMaterialButton(
                context: context,
                onPressed: () {
                  NavigateTo(context: context, widget: SignUpCompany());
                },
                labelWidget: Text(
                  'Sign up As a Company',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              SizedBox(height: 24.h),
              myMaterialButton(
                context: context,
                onPressed: () {
                  NavigateTo(context: context, widget: SignUpUser());
                },
                labelWidget: Text(
                  'Sign up As a User',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
