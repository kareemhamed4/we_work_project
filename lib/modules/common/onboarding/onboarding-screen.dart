import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_work/modules/common/login/user_login.dart';
import 'package:we_work/network/local/cache_helper.dart';
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
                      .titleLarge!
                      .copyWith(color: myFavColor),
                ),
                SizedBox(height: 39.h),
                Text(
                  'helps you in your online job search to find Jobs in Egypt and Middle East. Choose the right job using our online recruitment services',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 16.sp, height: 1.5),
                ),
                SizedBox(height: 77.h),
                myMaterialButton(
                  context: context,
                  onPressed: () {
                    CacheHelper.saveData(key: "onBoarding", value: true)
                        .then((value) {
                      NavigateToReb(
                          context: context, widget: LoginUser());
                    });
                  },
                  labelWidget: Text(
                    'Continue',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                SizedBox(height: 88.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: myTextButton(
                      context: context,
                      label: "SKIP",
                      onPressed: () {
                        CacheHelper.saveData(key: "onBoarding", value: true)
                            .then((value) {
                          NavigateToReb(
                              context: context, widget: LoginUser());
                        });
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
