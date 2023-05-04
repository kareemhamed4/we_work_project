import 'package:flutter/material.dart';
import 'package:we_work/shared/components/user_compont.dart';

class CompanyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Center(
          child: Text(
            "My Profile",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                radius: 30,
                backgroundImage: AssetImage("assets/image/google (1) 1.png"),
                foregroundColor: Colors.white,
              )),
              Text(
                "Google",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              Item(
                iconPath: "assets/icons/activity.png",
                title: 'Activity',
              ),

              Item(
                iconPath: "assets/icons/location.png",
                title: 'Location',
              ),
              Item(
                iconPath: "assets/icons/location.png",
                title: 'Location',
              ),
              Item(
                iconPath: "assets/icons/education.png",
                title: 'Number of employee',
              ),
              Item(
                iconPath: "assets/icons/location.png",
                title: 'Address',
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                  ),
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 15,
                      ),
                      Icon(
                        Icons.power_settings_new_rounded,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Logout",
                        style: TextStyle(color: Colors.red),
                      ),
                      Flexible(
                          child: SizedBox(
                        width: double.infinity,
                      )),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 18,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
