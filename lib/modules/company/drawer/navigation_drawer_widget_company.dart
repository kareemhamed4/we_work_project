import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_work/modules/common/choose_signup/selection_sign_up.dart';
import 'package:we_work/modules/company/profile/cubit/cubit.dart';
import 'package:we_work/modules/company/profile/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class NavigationDrawerWidgetCompany extends StatefulWidget {
  const NavigationDrawerWidgetCompany({super.key});

  @override
  State<NavigationDrawerWidgetCompany> createState() =>
      _NavigationDrawerWidgetCompanyState();
}

class _NavigationDrawerWidgetCompanyState
    extends State<NavigationDrawerWidgetCompany> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompanyProfileCubit,CompanyProfileStates>(
      listener: (context,state){},
      builder: (context,state){
        CompanyProfileCubit cubit = BlocProvider.of(context);
        return Material(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 80,),
              if (cubit.companyProfileModel != null &&
                  cubit.companyProfileModel!.profilePictureUrl != null)
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                      cubit.companyProfileModel!.profilePictureUrl!),
                ),
              if (cubit.companyProfileModel != null && cubit.companyProfileModel!.profilePictureUrl == null)
                CircleAvatar(
                  radius: 35,
                  backgroundColor: myFavColor3,
                  child: Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: myFavColor4,
                      )),
                ),
              if (cubit.companyProfileModel == null)
                CircleAvatar(
                  radius: 35,
                  backgroundColor: myFavColor3,
                  child: Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: myFavColor4,
                      )),
                ),
              const SizedBox(height: 30,),
              Container(
                padding: padding,
                child: Column(
                  children: [
                    buildMenuItem(
                      isChecked: true,
                      text: 'Name',
                      icon: FontAwesomeIcons.fileSignature,
                      onClicked: () => selectedItem(context, 0),
                    ),
                    buildMenuItem(
                      isChecked: false,
                      text: 'Location',
                      icon: FontAwesomeIcons.locationDot,
                      onClicked: () => selectedItem(context, 2),
                    ),
                    buildMenuItem(
                      isChecked: false,
                      text: 'Email',
                      icon: FontAwesomeIcons.envelope,
                      onClicked: () => selectedItem(context, 5),
                    ),
                    buildMenuItem(
                      isChecked: false,
                      text: 'BIO',
                      icon: FontAwesomeIcons.infoCircle,
                      onClicked: () => selectedItem(context, 3),
                    ),
                    const SizedBox(height: 50),
                    buildMenuItem(
                      isChecked: false,
                      text: 'Logout',
                      iconColor: Colors.red,
                      textColor: Colors.red,
                      icon: FontAwesomeIcons.powerOff,
                      onClicked: (){
                        NavigateToReb(
                          context: context,
                          widget: const ChooseRegister(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    Color? iconColor,
    Color? textColor,
    required bool isChecked,
    VoidCallback? onClicked,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: isChecked ? myFavColor2 : myFavColor5,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: Row(
            children: [
              FaIcon(icon,color: iconColor ?? myFavColor.withOpacity(0.6),),
              const SizedBox(
                width: 15,
              ),
              Text(text, style: TextStyle(color: textColor ?? myFavColor))
            ],
          ),
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => PeoplePage(),
      //));
        break;
      case 1:
      // Navigator.of(context).push(MaterialPageRoute(
      //   builder: (context) => FavouritesPage(),
      // ));
        break;
    }
  }
}
