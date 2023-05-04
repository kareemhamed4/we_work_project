import 'package:flutter/material.dart';
import 'package:we_work/modules/user/exam/Go_To_Exam.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
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
                  Text(
                    " 3Notification",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(color: myFavColor),
                  ),
                  Text(
                    " Today",
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ],
              ),
              const SizedBox(
                height: 23,
              ),
              Row(
                children: [
                  const CircleAvatar(
                      radius: 20, backgroundImage: NetworkImage(urlImage)),
                  const SizedBox(width: 20),
                  Flexible(
                    child: Text(
                      "manar you has apply to a job AS a ui ux designer",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      "assets/image/google (1) 1.png",
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 47,
              ),
              myDivider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const CircleAvatar(
                      radius: 20, backgroundImage: NetworkImage(urlImage)),
                  const SizedBox(width: 20),
                  Flexible(
                    child: Text(
                      "manar you has apply to a job AS a ui ux designer",
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.asset(
                      "assets/image/google (1) 1.png",
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: myMaterialButton(
                      context: context,
                      onPressed: () {},
                      isEnabled: false,
                      bgColorForNotEnabled: myFavColor2,
                      labelWidget: Text(
                        "Deny",
                        style: Theme.of(context)
                            .textTheme
                            .button!
                            .copyWith(color: myFavColor),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 36,
                  ),
                  Expanded(
                    child: myMaterialButton(
                      context: context,
                      labelWidget: Text(
                        "Accept",
                        style: Theme.of(context).textTheme.button,
                      ),
                      onPressed: () {
                        NavigateTo(context: context, widget: const GoToExam());
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              myDivider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage(
                      "assets/image/google (1) 1.png",
                    ),
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(width: 20),
                  Flexible(
                      child: Text(
                    "HI,,Manar, congratulation  i hope best wishes for you ",
                    style: TextStyle(color: Colors.grey),
                  ))
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
