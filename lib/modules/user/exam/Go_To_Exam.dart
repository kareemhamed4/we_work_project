import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_work/modules/user/exam/exam_Form.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class GoToExam extends StatelessWidget {
  const GoToExam({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 64/size.height,
            ),
            Image.asset("assets/image/Congratulation.png"),
            SizedBox(
              height: size.height * 47/size.height,
            ),
            Text(
              "Congratulation",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 18.sp,color: myFavColor),
            ),
            SizedBox(
              height: size.height * 30/size.height,
            ),
            Text(
                "Welcome and thank you for accepting our offer",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: size.height * 165/size.height,
            ),
            myMaterialButton(
              context: context,
              onPressed: () {
                NavigateTo(
                    context: context, widget: const ExamForm());
              },
              labelWidget: Text(
                'Go To Exam',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            SizedBox(
              height: size.height * 30/size.height,
            ),
          ],
        ),
      ),
    );
  }
}
