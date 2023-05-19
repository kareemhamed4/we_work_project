/*
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we_work/modules/user/upload_cv/Upload_Cv.dart';
import 'package:we_work/modules/user/company_details/microsoft_company.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class MicrosoftJobDetails extends StatelessWidget {
  const MicrosoftJobDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Details',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: myFavColor, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 76,
                width: 97,
                child: SvgPicture.asset(
                  "assets/image/microsoft.svg",
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              Text(
                "Microsoft",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_pin,
                    color: myFavColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Alex, Egypt",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Icon(
                    Icons.calendar_month_sharp,
                    color: myFavColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Full time",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Icon(
                    Icons.business,
                    color: myFavColor,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Remotely",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: myFavColor7.withOpacity(0.5),
                      ),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/image/positive-vote 1.png"),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Senior",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/image/experience 1.png"),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "1-3 year",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/image/earning 1.png"),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "300\$",
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 21,
              ),
              Card(
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: myFavColor7.withOpacity(0.5),
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: myMaterialButton(
                              context: context,
                              onPressed: () {},
                              labelWidget: Text(
                                "Description",
                                style: Theme.of(context).textTheme.button,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 36,
                          ),
                          Expanded(
                            child: myMaterialButton(
                              context: context,
                              isEnabled: false,
                              labelWidget: Text(
                                "Company",
                                style: Theme.of(context).textTheme.button!.copyWith(color: myFavColor7),
                              ),
                              onPressed: () {
                                NavigateTo(
                                    context: context,
                                    widget: const MicrosoftCompany());
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          "Job Description",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: myFavColor, fontSize: 16),
                        ),
                      ),
                      Text(
                        '''
Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,
''',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 14,height: 1.5),
                      ),
                      Text(
                        "Job Requirement",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: myFavColor, fontSize: 16),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff649344)),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            const Flexible(
                              child: Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting",
                                style:
                                TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff649344)),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            const Flexible(
                              child: Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting",
                                style:
                                TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          children: [
                            Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xff649344)),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            const Flexible(
                              child: Text(
                                "Lorem Ipsum is simply dummy text of the printing and typesetting",
                                style:
                                TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 29,
              ),
              myMaterialButton(
                context: context,
                onPressed: () {
                  NavigateTo(
                      context: context, widget: const UploadCv());
                },
                labelWidget: Text(
                  'Apply Job',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/
