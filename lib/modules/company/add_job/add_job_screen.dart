import 'package:flutter/material.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class AddJobScreen extends StatelessWidget {
  AddJobScreen({super.key});
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController jobTypeController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController skillsController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController workPlaceController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Job',
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
                  'Title',
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
                  controller: titleController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter job title";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'Description',
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
                  controller: descriptionController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter job description";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'position',
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
                  controller: positionController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter job position";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'Job Type',
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
                  controller: jobTypeController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter job type";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'Requirement',
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
                  controller: requirementsController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter job requirements";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'City',
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
                  controller: cityController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the city";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'Country',
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
                  controller: countryController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the country";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'Skills',
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
                  controller: skillsController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter required skills";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'Experience',
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
                  controller: experienceController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter job Experience";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'Salary',
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
                  controller: salaryController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the salary";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: size.height * 20 / size.height,
                ),
                Text(
                  'Work place',
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
                  controller: workPlaceController,
                  type: TextInputType.text,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return "Please enter job work place";
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
