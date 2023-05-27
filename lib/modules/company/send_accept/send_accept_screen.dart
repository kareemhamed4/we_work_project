import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:we_work/layout_company/cubit/cubit.dart';
import 'package:we_work/layout_company/layout_screen.dart';
import 'package:we_work/modules/company/notification/cubit/cubit.dart';
import 'package:we_work/modules/company/offers/cubit/cubit.dart';
import 'package:we_work/modules/company/offers/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class SendAcceptScreen extends StatelessWidget {
  final String userId;
  final bool isFreelance;
  SendAcceptScreen({Key? key, required this.userId,required this.isFreelance}) : super(key: key);
  final TextEditingController messageController = TextEditingController();
  final TextEditingController meetingTopicController = TextEditingController();
  final TextEditingController meetingAgendaController = TextEditingController();
  final TextEditingController meetingDateController = TextEditingController();
  final TextEditingController meetingTimeController = TextEditingController();
  final TextEditingController meetingDurationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    DateTime dateTime = DateTime.now();
    return BlocConsumer<CompanyOffersCubit, CompanyOffersStates>(
      listener: (context, state) {
        if (state is CompanyAcceptFreeLanceOfferSuccessState) {
          CompanyGetUsersWhoAppliedCubit.get(context)
              .companyGetAllMeetings()
              .then((value) {
            NavigateToReb(
                context: context, widget: const LayoutCompanyScreen());
            LayoutCompanyCubit.get(context).changeIndex(1, context);
            CompanyGetUsersWhoAppliedCubit.get(context).changeTabBarIndex(1);
            buildSuccessToast(
              context: context,
              title: isFreelance ? "Accepted!" : "Created!",
              description: state.msg,
            );
          });
        }
        if (state is CompanyAcceptFreeLanceOfferErrorState) {
          buildErrorToast(
            context: context,
            title: "Oops!",
            description: state.error,
          );
        }
        if (state is CreateMeetingSuccessState) {
          CompanyOffersCubit.get(context).companyAcceptFreelanceOffer(
            userId: userId,
            message: messageController.text,
            meetingDate: meetingDateController.text,
            meetingLink: CompanyOffersCubit.get(context).meetingUrl ?? "null",
          );
        }
      },
      builder: (context, state) {
        CompanyOffersCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              isFreelance ? 'Send Accept' : "Create Meeting",
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Meeting Topic",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16,
                          color: myFavColor,
                        ),
                  ),
                  mySizedBox(size: size, myHeight: 12),
                  myTextFormField(
                    context: context,
                    controller: meetingTopicController,
                    hint: "Meeting Topic",
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Please enter meeting topic";
                      }
                      return null;
                    },
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Icon(
                            Icons.type_specimen_outlined,
                            color: myFavColor4,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 20),
                  Text(
                    "Meeting Agenda",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16,
                          color: myFavColor,
                        ),
                  ),
                  mySizedBox(size: size, myHeight: 12),
                  myTextFormField(
                    context: context,
                    controller: meetingAgendaController,
                    hint: "Meeting Agenda",
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Please enter meeting agenda";
                      }
                      return null;
                    },
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Icon(
                            Icons.type_specimen_outlined,
                            color: myFavColor4,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 20),
                  Text(
                    "Meeting Date",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16,
                          color: myFavColor,
                        ),
                  ),
                  mySizedBox(size: size, myHeight: 12),
                  myTextFormField(
                    context: context,
                    controller: meetingDateController,
                    hint: DateTime.now().toString().substring(0, 10),
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      ).then((value) => value != null
                          ? {
                              meetingDateController.text =
                                  DateFormat('d-M-y').format(value),
                              dateTime = value,
                            }
                          : meetingDateController.text = "");
                    },
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Icon(
                            Icons.calendar_month_outlined,
                            color: myFavColor4,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: myFavColor,
                        ),
                      ],
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 20),
                  Text(
                    "Meeting Time",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16,
                          color: myFavColor,
                        ),
                  ),
                  mySizedBox(size: size, myHeight: 12),
                  myTextFormField(
                    context: context,
                    controller: meetingTimeController,
                    hint: "10:14 AM",
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      ).then((value) => value != null
                          ? meetingTimeController.text = value.format(context)
                          : meetingTimeController.text = "");
                    },
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Icon(
                            Icons.watch_later_outlined,
                            color: myFavColor4,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: myFavColor,
                        ),
                      ],
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 20),
                  Text(
                    "Meeting Duration",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16,
                          color: myFavColor,
                        ),
                  ),
                  mySizedBox(size: size, myHeight: 12),
                  myTextFormField(
                    context: context,
                    controller: meetingDurationController,
                    hint: "Meeting Duration in Minutes",
                    validate: (value) {
                      if (value!.isEmpty) {
                        return "Please enter meeting duration";
                      }
                      return null;
                    },
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Icon(
                            Icons.watch_later_outlined,
                            color: myFavColor4,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 20),
                  Text(
                    "Message",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 16,
                          color: myFavColor,
                        ),
                  ),
                  mySizedBox(size: size, myHeight: 12),
                  myTextFormField(
                    context: context,
                    controller: messageController,
                    hint: "Message",
                    prefixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: Icon(
                            Icons.type_specimen_outlined,
                            color: myFavColor4,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 30),
                  ConditionalBuilder(
                    condition:
                        state is! CompanyAcceptFreeLanceOfferLoadingState,
                    builder: (context) => myMaterialButton(
                      context: context,
                      onPressed: () {
                        cubit.createZoomMeeting(
                          topic: meetingTopicController.text,
                          agenda: meetingAgendaController.text,
                          date: DateFormat('y-M-d').format(dateTime),
                          time: double.parse(meetingTimeController.text
                              .replaceAll(":", ".")
                              .split(" ")
                              .first),
                          duration: int.parse(meetingDurationController.text),
                        );
                      },
                      labelWidget: Text(
                        isFreelance ? 'Send Accept' : "Create Meeting",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                    fallback: (context) => myMaterialButton(
                      context: context,
                      onPressed: () {
                        null;
                      },
                      labelWidget: const Center(
                        child: SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  mySizedBox(size: size, myHeight: 30),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
