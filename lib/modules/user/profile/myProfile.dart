import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_work/modules/common/choose_signup/Selection%20sign%20up.dart';
import 'package:we_work/shared/components/animated_progress_indicator.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class ExpansionItem {
  String headerText;
  String expandedText;
  bool isExpanded;
  IconData icon;

  ExpansionItem({
    required this.headerText,
    required this.expandedText,
    required this.icon,
    this.isExpanded = false,
  });
}

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final List<ExpansionItem> data = [
    ExpansionItem(
      headerText: "Name",
      expandedText: "Manar Maher",
      icon: FontAwesomeIcons.fileSignature,
    ),
    ExpansionItem(
      headerText: "CV",
      expandedText: "ManarResume.pdf",
      icon: FontAwesomeIcons.filePdf,
    ),
    ExpansionItem(
      headerText: "Location",
      expandedText: "Country: Egypt\nCity: Cairo",
      icon: FontAwesomeIcons.locationDot,
    ),
    ExpansionItem(
      headerText: "BIO",
      expandedText: "I believe in miracles.",
      icon: FontAwesomeIcons.infoCircle,
    ),
    ExpansionItem(
      headerText: "Education",
      expandedText: "Bachelor of Computers and Information",
      icon: FontAwesomeIcons.graduationCap,
    ),
    ExpansionItem(
      headerText: "Email",
      expandedText: "manarmaher@gmail.com",
      icon: FontAwesomeIcons.envelope,
    ),
  ];

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
        physics: const BouncingScrollPhysics(),
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
              mySizedBox(size: size, myHeight: 15),
              Text(
                "Manar Maher",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              mySizedBox(size: size, myHeight: 8),
              Text(
                "UI,Ux designer",
                style: Theme.of(context).textTheme.bodyText2,
              ),
              mySizedBox(size: size, myHeight: 19),
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
                  mySizedBox(size: size, myHeight: 15),
                  const AnimatedLinearProgressIndicator(
                    percentage: 0.42,
                    label: "Profile",
                  ),
                ],
              ),
              mySizedBox(size: size, myHeight: 10),
              ListView.builder(
                key: UniqueKey(),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0), // Adjust the bottom padding as needed
                    child: Card(
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: myFavColor7.withOpacity(0.4),
                        )
                      ),
                      child: ExpansionPanelList(
                        elevation: 0,
                        dividerColor: myFavColor7.withOpacity(0.5),
                        expandedHeaderPadding: EdgeInsets.zero, // Removes the default header padding
                        expansionCallback: (int panelIndex, bool isExpanded) {
                          setState(() {
                            data[index].isExpanded = !isExpanded;
                          });
                        },
                        children: [
                          ExpansionPanel(
                            headerBuilder: (BuildContext context, bool isExpanded) {
                              return ListTile(
                                title: Text(data[index].headerText,style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),),
                                leading: FaIcon(data[index].icon,color: myFavColor.withOpacity(0.6),),
                              );
                            },
                            body: ListTile(
                              title: Text(data[index].expandedText,style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 16),),
                            ),
                            isExpanded: data[index].isExpanded,
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
