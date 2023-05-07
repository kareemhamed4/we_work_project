import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_work/modules/common/choose_signup/Selection%20sign%20up.dart';
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

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({super.key});

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile> {
  final List<ExpansionItem> data = [
    ExpansionItem(
      headerText: "Name",
      expandedText: "Google",
      icon: FontAwesomeIcons.fileSignature,
    ),
    ExpansionItem(
      headerText: "Location",
      expandedText: "Country: Egypt\nCity: Alex",
      icon: FontAwesomeIcons.locationDot,
    ),
    ExpansionItem(
      headerText: "Email",
      expandedText: "google@gmail.com",
      icon: FontAwesomeIcons.envelope,
    ),
    ExpansionItem(
      headerText: "BIO",
      expandedText: "bla bla bla",
      icon: FontAwesomeIcons.infoCircle,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
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
