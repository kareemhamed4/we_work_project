import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_work/modules/common/choose_signup/selection_sign_up.dart';
import 'package:we_work/modules/user/profile/cubit/cubit.dart';
import 'package:we_work/modules/user/profile/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class NavigationDrawerWidget extends StatelessWidget {
  const NavigationDrawerWidget({super.key});
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileCubit,UserProfileStates>(
      listener: (context,state){},
      builder: (context,state){
        UserProfileCubit cubit = BlocProvider.of(context);
        return Material(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30,),
              if (cubit.userProfileModel != null &&
                  cubit.userProfileModel!.profilePictureUrl != null)
                CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                      cubit.userProfileModel!.profilePictureUrl!),
                ),
              if (cubit.userProfileModel != null && cubit.userProfileModel!.profilePictureUrl == null)
                CircleAvatar(
                  radius: 35,
                  backgroundColor: myFavColor3,
                  child: Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: myFavColor4,
                      )),
                ),
              if (cubit.userProfileModel == null)
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
                      text: 'CV',
                      icon: FontAwesomeIcons.filePdf,
                      onClicked: () => selectedItem(context, 1),
                    ),
                    buildMenuItem(
                      isChecked: false,
                      text: 'Location',
                      icon: FontAwesomeIcons.locationDot,
                      onClicked: () => selectedItem(context, 2),
                    ),
                    buildMenuItem(
                      isChecked: false,
                      text: 'BIO',
                      icon: FontAwesomeIcons.infoCircle,
                      onClicked: () => selectedItem(context, 3),
                    ),
                    buildMenuItem(
                      isChecked: false,
                      text: 'Education',
                      icon: FontAwesomeIcons.graduationCap,
                      onClicked: () => selectedItem(context, 4),
                    ),
                    buildMenuItem(
                      isChecked: false,
                      text: 'Email',
                      icon: FontAwesomeIcons.envelope,
                      onClicked: () => selectedItem(context, 5),
                    ),
                    const SizedBox(height: 30,),
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
