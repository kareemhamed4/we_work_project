import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:we_work/modules/common/choose_signup/Selection%20sign%20up.dart';
import 'package:we_work/shared/components/animated_progress_indicator.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/components/user_compont.dart';
import 'package:we_work/shared/styles/colors.dart';

class CompanyProfile extends StatelessWidget {
  const CompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: SvgPicture.asset(
                  "assets/image/google.svg",
                  width: 81,
                  height: 81,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Google",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(fontSize: 20),
              ),
              const SizedBox(height: 34),
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
                  onTap: () {
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
