import 'package:flutter/material.dart';

class CompanNotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Notification",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "You have 1Notifcation To day",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
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
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Divider(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
