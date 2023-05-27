import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_work/models/company/company_get_jobs_model.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class CompanyJobDetails extends StatelessWidget {
  final CompanyGetJobsModel companyGetJobsModel;
  const CompanyJobDetails({super.key, required this.companyGetJobsModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Details',
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: myFavColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (companyGetJobsModel.pictureUrl != null)
                CircleAvatar(
                  radius: 30,
                  backgroundColor: myFavColor3,
                  backgroundImage:
                  NetworkImage(companyGetJobsModel.pictureUrl!),
                ),
              if (companyGetJobsModel.pictureUrl == null)
                CircleAvatar(
                  radius: 25,
                  backgroundColor: myFavColor3,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: myFavColor4,
                  ),
                ),
              const SizedBox(
                height: 17,
              ),
              Text(
                companyGetJobsModel.title!,
                style: Theme.of(context).textTheme.bodyLarge,
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
                          "${companyGetJobsModel.city} , ${companyGetJobsModel.country}",
                          style: Theme.of(context).textTheme.bodyMedium,
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
                          companyGetJobsModel.jobType ?? "",
                          style: Theme.of(context).textTheme.bodyMedium,
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
                          companyGetJobsModel.workPlace ?? "",
                          style: Theme.of(context).textTheme.bodyMedium,
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
                              companyGetJobsModel.position!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 14.sp),
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
                              companyGetJobsModel.experience!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 14.sp),
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
                              companyGetJobsModel.salary.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontSize: 14.sp),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 15, bottom: 15),
                        child: Text(
                          "Job Description",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: myFavColor),
                        ),
                      ),
                      Text(
                        companyGetJobsModel.description!,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 14.sp, height: 1.5),
                      ),
                      const SizedBox(
                        height: 21,
                      ),
                      Text(
                        "Job Requirement",
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: myFavColor),
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
                                companyGetJobsModel.requirement!,
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
                bgColorForNotEnabled: myFavColor8,
                isEnabled: false,
                onPressed: () {

                },
                labelWidget: Text(
                  'Delete Job',
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
