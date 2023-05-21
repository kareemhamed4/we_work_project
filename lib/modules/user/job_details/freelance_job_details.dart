import 'package:flutter/material.dart';
import 'package:we_work/models/user/user_get_freelance_details_model.dart';
import 'package:we_work/modules/user/company_details/google_company.dart';
import 'package:we_work/modules/user/send_offer_freelance_job/send_offer_freelance_screen.dart';
import 'package:we_work/modules/user/upload_cv/Upload_Cv.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class FreelanceJobDetailsScreen extends StatelessWidget {
  final UserGetFreelanceDetailsModel userGetFreelanceDetailsModel;
  final int id;
  const FreelanceJobDetailsScreen({super.key, required this.userGetFreelanceDetailsModel,required this.id});

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
                userGetFreelanceDetailsModel.title ??"",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                userGetFreelanceDetailsModel.projectOwner ??"",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              const SizedBox(
                height: 32,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image.asset("assets/icons/status.png"),
                              const SizedBox(height: 20,),
                              Text(
                                userGetFreelanceDetailsModel.projectStatus ??"",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset("assets/icons/time.png"),
                              const SizedBox(height: 20,),
                              Text(
                                userGetFreelanceDetailsModel.timeToComplete ??"",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset("assets/icons/money.png"),
                              const SizedBox(height: 20,),
                              Text(
                                userGetFreelanceDetailsModel.budget ??"",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(fontSize: 14),
                              ),
                            ],
                          ),
                        ],
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
                        userGetFreelanceDetailsModel.projectDetails ??"",
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
                                userGetFreelanceDetailsModel.requiredSkills ??"",
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
                      widget: UserSendOfferToFreelanceJobScreen(
                        jobId: id,
                      ));
                },
                labelWidget: Text(
                  'Send Offer',
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