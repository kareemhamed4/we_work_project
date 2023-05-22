import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we_work/layout/layout_screen.dart';
import 'package:we_work/models/user/user_get_applied_jobs_model.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class ApplicateDetailsForGoogle extends StatelessWidget {
  final UserGetAppliedJobsModel userGetAppliedJobsModel;
  const ApplicateDetailsForGoogle({super.key,required this.userGetAppliedJobsModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Applicate Details',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: myFavColor, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 37,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 32,
                            width: 32,
                            child: SvgPicture.asset("assets/image/google.svg")
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Google",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "UI,Ux Designer",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "This job posted in 10 dec 2022",
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Job Details",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: myFavColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.location_pin,
                            color: Color(0xff649344),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Alex , EGYPT",
                            style:
                                TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.calendar_month_sharp,
                            color: Color(0xff649344),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Full time",
                            style:
                                TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.business,
                            color: Color(0xff649344),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "Remotely",
                            style:
                                TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Text(
                        "CV Resume",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: myFavColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                          border: Border.all(
                            color: Colors.grey.shade300,
                          ),
                        ),
                        height: 70,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset("assets/image/pdf 1.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text("Manar cv ui ux designer")
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Interview Details",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: myFavColor),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.update,
                            color: Color(0xff649344),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "12:00Am",
                            style:
                                TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.calendar_month_sharp,
                            color: Color(0xff649344),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text(
                            "13 dec 2022",
                            style:
                                TextStyle(fontSize: 15, color: Colors.grey),
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
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: myMaterialButton(
                context: context,
                onPressed: () {
                  NavigateTo(
                      context: context, widget: const LayoutScreen());
                },
                labelWidget: Text(
                  'Online Meeting',
                  style: Theme.of(context).textTheme.button,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
