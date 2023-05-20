import 'package:flutter/material.dart';
import 'package:we_work/models/user/user_get_job_details_model.dart';
import 'package:we_work/modules/user/company_details/google_company.dart';
import 'package:we_work/modules/user/upload_cv/Upload_Cv.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class GoogleJobDetails extends StatelessWidget {
  final UserGetJobDetailsModel userGetJobDetailsModel;
  const GoogleJobDetails({super.key, required this.userGetJobDetailsModel});

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
                child: Image.asset(
                  "assets/image/Google.png",
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              Text(
                userGetJobDetailsModel.title!,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
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
                          "${userGetJobDetailsModel.city} , ${userGetJobDetailsModel.country}",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_month_sharp,
                          color: myFavColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          userGetJobDetailsModel.jobType ?? "",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.business,
                          color: myFavColor,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          userGetJobDetailsModel.workPlace ?? "",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
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
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/image/positive-vote 1.png"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              userGetJobDetailsModel.position!,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/image/experience 1.png"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              userGetJobDetailsModel.experience!,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/image/earning 1.png"),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              userGetJobDetailsModel.salary.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        ),
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
                                style: Theme.of(context)
                                    .textTheme
                                    .button!
                                    .copyWith(color: myFavColor7),
                              ),
                              onPressed: () {
                                NavigateTo(
                                    context: context,
                                    widget: const GoogleCompany());
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
                        userGetJobDetailsModel.description!,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 14, height: 1.5),
                      ),
                      const SizedBox(
                        height: 21,
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
                            Flexible(
                              child: Text(
                                userGetJobDetailsModel.requirement!,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
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
                      context: context,
                      widget: UploadCv(jobId: userGetJobDetailsModel.id!,));
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
