import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  String verticalGroupValueExperience = "1 year";
  List<String> experience = [
    "No Experience",
    "less than year",
    "1 year",
    "2-3 year",
    "more than 10 years"
  ];
  String verticalGroupValue = "Cairo in Egypt";
  String verticalGroupValueTypeOfWorkPlace = "Remotely";
  List<String> statusTypeOfWorkPlace = ["onsite", "Remotely"];
  List<String> statusLocation = [
    "Cairo in Egypt",
    "Alex in Egypt",
    "mansoura in Egypt ",
    "In other country"
  ];
  SfRangeValues _values = const SfRangeValues(120, 300);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Filter',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: myFavColor, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Location",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: myFavColor),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded,color: myFavColor7,),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              RadioGroup<String>.builder(
                fillColor: myFavColor,
                activeColor: myFavColor,
                groupValue: verticalGroupValue,
                onChanged: (value) => setState(() {
                  verticalGroupValue = value!;
                }),
                items: statusLocation,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),
              myDivider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Type of workplace",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: myFavColor),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded,color: myFavColor7,),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              RadioGroup<String>.builder(
                fillColor: const Color(0xff649344),
                groupValue: verticalGroupValueTypeOfWorkPlace,
                onChanged: (value) => setState(() {
                  verticalGroupValueTypeOfWorkPlace = value!;
                }),
                items: statusTypeOfWorkPlace,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),
              myDivider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Job type",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: myFavColor),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded,color: myFavColor7,),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoRadioChoice(
                selectedColor: myFavColor,
                notSelectedColor: myFavColor7,
                choices: const {
                  'Full time': 'Full time',
                  'part time': 'part time',
                  'internship': 'internship',
                  'project based': 'project based'
                },
                onChange: (selectedGender) {},
                initialKeyValue: 'Full time',
              ),
              const SizedBox(
                height: 20,
              ),
              myDivider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Position level",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: myFavColor),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded,color: myFavColor7,),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoRadioChoice(
                  selectedColor: myFavColor,
                  notSelectedColor: myFavColor7,
                  choices: const {
                    'Senior': 'Senior',
                    'junior': 'junior',
                    'manager': 'manager',
                    'Leader': 'Leader'
                  },
                  onChange: (selectedGender) {},
                  initialKeyValue: 'Senior',
              ),
              const SizedBox(
                height: 20,
              ),
              myDivider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Salary",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: myFavColor),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded,color: myFavColor7,),
                ],
              ),
              SfRangeSlider(
                  inactiveColor: myFavColor3,
                  activeColor: myFavColor,
                  min: 10,
                  max: 500,
                  stepSize: 1,
                  enableIntervalSelection: true,
                  showDividers: false,
                  values: _values,
                  interval: 40,
                  showTicks: false,
                  showLabels: false,
                  enableTooltip: true,
                  minorTicksPerInterval: 1,
                  onChanged: (SfRangeValues values) {
                    setState(() {
                      _values = values;
                    });
                  }),
              const SizedBox(
                height: 20,
              ),
              myDivider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Experience",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: myFavColor),
                  ),
                  Icon(Icons.keyboard_arrow_down_rounded,color: myFavColor7,),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              RadioGroup<String>.builder(
                fillColor: myFavColor,
                activeColor: myFavColor,
                groupValue: verticalGroupValueExperience,
                onChanged: (value) => setState(
                  () {
                    verticalGroupValueExperience = value!;
                  },
                ),
                items: experience,
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              myDivider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: myMaterialButton(
                      context: context,
                      bgColorForNotEnabled: myFavColor2,
                      isEnabled: false,
                      labelWidget: Text(
                        "Reset",
                        style: Theme.of(context).textTheme.button!.copyWith(color: myFavColor),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 36,
                  ),
                  Expanded(
                    flex: 2,
                    child: myMaterialButton(
                      context: context,
                      onPressed: () {},
                      labelWidget: Text(
                        "Apply",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
