import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class CompanyFilter extends StatefulWidget {
  const CompanyFilter({super.key});

  @override
  State<CompanyFilter> createState() => _CompanyFilterState();
}

class _CompanyFilterState extends State<CompanyFilter> {
  String verticalGroupValueExperience = "more than 10 years";
  List<String> experience = [
    "No Experience",
    "less than year",
    "1 year",
    "2-3 year",
    "more than 10 years"
  ];

  String verticalGroupValueTypeOfWorkPlace = "Remotely";
  List<String> statusTypeOfWorkPlace = ["onsite", "Remotely"];

  String selectedCountry = "Egypt";
  List<String> countries = [
    "Egypt",
    "Palestine"
  ];

  String selectedCity = "Alex";
  List<String> cities = [
    "Cairo",
    "Alex"
  ];
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
        physics: const BouncingScrollPhysics(),
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
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: myFavColor7,
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Country",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: myFavColor,fontSize: 16),
                          ),
                          RadioGroup<String>.builder(
                            fillColor: myFavColor,
                            activeColor: myFavColor,
                            groupValue: selectedCountry,
                            textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14),
                            onChanged: (value) => setState(() {
                              selectedCountry = value!;
                            }),
                            items: countries,
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(flex: 1,child: SizedBox()),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "City",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: myFavColor,fontSize: 16),
                          ),
                          RadioGroup<String>.builder(
                            fillColor: myFavColor,
                            activeColor: myFavColor,
                            groupValue: selectedCity,
                            textStyle: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 14),
                            onChanged: (value) => setState(() {
                              selectedCity = value!;
                            }),
                            items: cities,
                            itemBuilder: (item) => RadioButtonBuilder(
                              item,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
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
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: myFavColor7,
                  ),
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
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: myFavColor7,
                  ),
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
                height: 30,
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
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: myFavColor7,
                  ),
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
                height: 40,
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
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: myFavColor),
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
