import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class NextExamForm extends StatefulWidget {
  const NextExamForm({super.key});

  @override
  State<NextExamForm> createState() => _NextExamFormState();
}

class _NextExamFormState extends State<NextExamForm> {
  String verticalGroupValue1 = "Yes";
  List<String> status1 = ["Yes", "No"];

  String verticalGroupValue2 = "Yes";
  List<String> status2 = ["Yes", "No"];

  String verticalGroupValue3 = "Yes";
  List<String> status3 = ["Yes", "No"];

  String verticalGroupValue4 = "Yes";
  List<String> status4 = ["Yes", "No"];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Exam Form',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: myFavColor),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Do You Work on socket io?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            RadioGroup<String>.builder(
              fillColor: myFavColor,
              activeColor: myFavColor,
              groupValue: verticalGroupValue1,
              onChanged: (value) => setState(() {
                verticalGroupValue1 = value!;
              }),
              items: status1,
              itemBuilder: (item) => RadioButtonBuilder(
                item,
              ),
            ),
            SizedBox(
              height: size.height * 20 / size.height,
            ),
            Text(
              'Do You Work on ML Model?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            RadioGroup<String>.builder(
              fillColor: myFavColor,
              activeColor: myFavColor,
              groupValue: verticalGroupValue2,
              onChanged: (value) => setState(() {
                verticalGroupValue2 = value!;
              }),
              items: status2,
              itemBuilder: (item) => RadioButtonBuilder(
                item,
              ),
            ),
            SizedBox(
              height: size.height * 20 / size.height,
            ),
            Text(
              'Do You have experience in animation?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            RadioGroup<String>.builder(
              fillColor: myFavColor,
              activeColor: myFavColor,
              groupValue: verticalGroupValue3,
              onChanged: (value) => setState(() {
                verticalGroupValue3 = value!;
              }),
              items: status3,
              itemBuilder: (item) => RadioButtonBuilder(
                item,
              ),
            ),
            SizedBox(
              height: size.height * 20 / size.height,
            ),
            Text(
              'Do you known responsive ui?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            RadioGroup<String>.builder(
              fillColor: myFavColor,
              activeColor: myFavColor,
              groupValue: verticalGroupValue4,
              onChanged: (value) => setState(() {
                verticalGroupValue4 = value!;
              }),
              items: status4,
              itemBuilder: (item) => RadioButtonBuilder(
                item,
              ),
            ),
            SizedBox(
              height: size.height * 20 / size.height,
            ),
            myMaterialButton(
              context: context,
              onPressed: () {
                NavigateToReb(context: context, widget: const LayoutScreen());
              },
              labelWidget: Text(
                'Send',
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
