import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:we_work/modules/company/applied_job/applied_job_screen.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class CompanyNotificationScreen extends StatelessWidget {
  const CompanyNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: myFavColor, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "You have",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  myTextButton(
                      context: context,
                      label: "1Notification",
                      onPressed: (){
                        NavigateTo(
                            context: context,
                            widget: const AppliedJobScreen(),
                        );
                      }
                  ),
                  Text(
                    "Today",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SvgPicture.asset("assets/image/google.svg"),
                  const SizedBox(width: 20),
                  Flexible(
                    child: Text(
                      "manar applied for a job as a UI/UX designer",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              myDivider(),
            ],
          ),
        ),
      ),
    );
  }
}
