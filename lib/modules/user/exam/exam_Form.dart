import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:we_work/modules/user/exam/next_Exam_Form.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class ExamForm extends StatefulWidget {
  const ExamForm({super.key});

  @override
  State<ExamForm> createState() => _ExamFormState();
}

class _ExamFormState extends State<ExamForm> {
  TextEditingController? textMessageController;
  String? messageEnter;
  String verticalGroupValue = "Yes";
  List<String> status = ["Yes", "No"];
  String verticalGroupValue0 = "Yes";
  List<String> status0 = ["Yes", "No"];
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              myTextFormField(
                context: context,
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
                'Full_Name',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              myTextFormField(
                context: context,
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
                'Experience in flutter',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              myTextFormField(
                context: context,
                type: TextInputType.text,
                validate: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: size.height * 20 / size.height,
              ),
              Text(
                'Experience in programming',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              myTextFormField(
                context: context,
                type: TextInputType.text,
                validate: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: size.height * 20 / size.height,
              ),
              Text(
                'Number of projects in google play',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              myTextFormField(
                context: context,
                type: TextInputType.text,
                validate: (value) {
                  if (value!.isEmpty) {
                    return "This field is required";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: size.height * 20 / size.height,
              ),
              Text(
                'Do You Work With restful app?',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              RadioGroup<String>.builder(
                fillColor: myFavColor,
                activeColor: myFavColor,
                groupValue: verticalGroupValue,
                onChanged: (value) => setState(() {
                  verticalGroupValue = value!;
                }),
                items: status,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),
              SizedBox(
                height: size.height * 20 / size.height,
              ),
              Text(
                'What is the State management deal with this?',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                height: 120,
                width: double.infinity,
                child: TextField(
                  controller: textMessageController,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 1,
                  maxLines: null,
                  onChanged: ((value) {
                    setState(() {
                      messageEnter = value;
                    });
                  }),
                  decoration: InputDecoration(
                    hintMaxLines: 1,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 25),
                    hintStyle: const TextStyle(
                      fontSize: 16,
                    ),
                    fillColor: Colors.white,
                    filled: false,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: .2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: const BorderSide(
                        color: Colors.white,
                        width: 0.2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 20 / size.height,
              ),
              Text(
                'Do you work on google map?',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 8,
              ),
              RadioGroup<String>.builder(
                fillColor: myFavColor,
                activeColor: myFavColor,
                groupValue: verticalGroupValue0,
                onChanged: (value) => setState(() {
                  verticalGroupValue0 = value!;
                }),
                items: status0,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),
              myMaterialButton(
                context: context,
                onPressed: () {
                  NavigateTo(context: context, widget: const NextExamForm());
                },
                labelWidget: Text(
                  'Next',
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
