import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:we_work/layout/cubit/cubit.dart';
import 'package:we_work/layout/cubit/states.dart';
import 'package:we_work/shared/styles/colors.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<LayoutCubit, LayoutStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        LayoutCubit cubit = BlocProvider.of(context);
        return Scaffold(
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Container(
              width: double.infinity,
              height: size.height * 74 / size.height,
              decoration: BoxDecoration(
                color: myFavColor,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        cubit.changeIndex(0);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.house,color: myFavColor5,),
                          if (cubit.currentIndex == 0)
                            const SizedBox(
                              height: 12,
                            ),
                          if (cubit.currentIndex == 0)
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: myFavColor5,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        cubit.changeIndex(1);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.bell,color: myFavColor5,),
                          if (cubit.currentIndex == 1)
                            const SizedBox(
                              height: 12,
                            ),
                          if (cubit.currentIndex == 1)
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: myFavColor5,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        cubit.changeIndex(2);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.bookmark,color: myFavColor5,),
                          if (cubit.currentIndex == 2)
                            const SizedBox(
                              height: 12,
                            ),
                          if (cubit.currentIndex == 2)
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: myFavColor5,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        cubit.changeIndex(3);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/icons/offers.png",width: 32,height: 32,),
                          if (cubit.currentIndex == 3)
                            const SizedBox(
                              height: 12,
                            ),
                          if (cubit.currentIndex == 3)
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: myFavColor5,
                            ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        cubit.changeIndex(4);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.user,color: myFavColor5,),
                          if (cubit.currentIndex == 4)
                            const SizedBox(
                              height: 12,
                            ),
                          if (cubit.currentIndex == 4)
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: myFavColor5,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /*bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                      icon: Container(
                        decoration: (cubit.currentIndex == 0)
                            ? BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: myFavColor, width: 3)))
                            : const BoxDecoration(),
                        child: Column(
                          children: const [
                            SizedBox(
                              height: 14,
                            ),
                            Icon(Icons.home),
                          ],
                        ),
                      ),
                      label: "Home"),
                  BottomNavigationBarItem(
                      icon: Container(
                          decoration: (cubit.currentIndex == 1)
                              ? BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: myFavColor, width: 3)))
                              : const BoxDecoration(),
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 14,
                              ),
                              Icon(Icons.home),
                            ],
                          )),
                      label: "Tracking"),
                  BottomNavigationBarItem(
                      icon: Container(
                          decoration: (cubit.currentIndex == 2)
                              ? BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: myFavColor, width: 3)))
                              : const BoxDecoration(),
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 14,
                              ),
                              Icon(Icons.home),
                            ],
                          )),
                      label: "Services"),
                  BottomNavigationBarItem(
                      icon: Container(
                          decoration: (cubit.currentIndex == 3)
                              ? BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: myFavColor, width: 3)))
                              : const BoxDecoration(),
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 14,
                              ),
                              Icon(Icons.home),
                            ],
                          )),
                      label: "Profile"),
                ],
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
              ),
            ],
          ),*/
        );
      },
    );
  }
}
