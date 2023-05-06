import 'package:flutter/material.dart';
import 'package:we_work/modules/common/choose_signup/Selection%20sign%20up.dart';
import 'package:we_work/shared/components/animated_progress_indicator.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/components/user_compont.dart';
import 'package:we_work/shared/styles/colors.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Profile',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: myFavColor, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Center(
                child: CircleAvatar(
                  radius: 39,
                  backgroundImage: NetworkImage(urlImage),
                ),
              ),
              mySizedBox(size: size,myHeight: 15),
              Text(
                "Manar Maher",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              mySizedBox(size: size,myHeight: 8),
              Text(
                "UI,Ux designer",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              mySizedBox(size: size,myHeight: 19),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Complete your profile",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontSize: 16),
                      ),
                      Text(
                        "(3/7)",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: myFavColor),
                      ),
                    ],
                  ),
                  mySizedBox(size: size,myHeight: 15),
                  const AnimatedLinearProgressIndicator(
                    percentage: 0.42,
                    label: "Profile",
                  ),
                ],
              ),
              mySizedBox(size: size,myHeight: 10),
              Item(
                iconPath: "assets/icons/activity.png",
                title: 'Skills',
              ),
              Item(
                iconPath: "assets/icons/location.png",
                title: 'Location',
              ),
              Item(
                iconPath: "assets/icons/education.png",
                title: 'Education',
              ),
              Item(
                iconPath: "assets/icons/language.png",
                title: 'Language',
              ),
              Item(
                iconPath: "assets/icons/cv.png",
                title: 'Cv',
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GestureDetector(
                  onTap: (){
                    NavigateToReb(
                        context: context,
                        widget: const ChooseRegister(),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      border: Border.all(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      children: const [
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
