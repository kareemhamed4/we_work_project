import 'package:flutter/material.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class AddFreelanceJobScreen extends StatelessWidget {
  AddFreelanceJobScreen({super.key});
  TextEditingController statueController = TextEditingController();
  TextEditingController publicTimeController = TextEditingController();
  TextEditingController timeToCompleteController = TextEditingController();
  TextEditingController projectDetailsController = TextEditingController();
  TextEditingController requiresSkillsController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Freelance job',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: myFavColor, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
                  'Project statue',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 14),
                ),
                const SizedBox(
                  height: 8,
                ),
                myTextFormField(
                  context: context,
                  controller: statueController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Project statue";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'Public time',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 14),
                ),
                const SizedBox(
                  height: 8,
                ),
                myTextFormField(
                  context: context,
                  controller: publicTimeController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter Public time";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'Time to complete',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 14),
                ),
                const SizedBox(
                  height: 8,
                ),
                myTextFormField(
                  context: context,
                  controller: timeToCompleteController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter time to complete";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),

                Text(
                  'project details',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 14),
                ),
                const SizedBox(
                  height: 8,
                ),
                myTextFormField(
                  context: context,
                  controller: projectDetailsController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter project details";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'requires skills',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontSize: 14),
                ),
                const SizedBox(
                  height: 8,
                ),
                myTextFormField(
                  context: context,
                  controller: projectDetailsController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter requires skills";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                myMaterialButton(
                  context: context,
                  onPressed: () {},
                  labelWidget: Text(
                    'Confirm',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                SizedBox(
                  height: size.height * 8 / size.height,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
