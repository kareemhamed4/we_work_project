import 'dart:async';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/modules/company/home/cubit/cubit.dart';
import 'package:we_work/modules/company/home/cubit/states.dart';
import 'package:we_work/modules/company/offers/cubit/cubit.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class MessageOfferScreen extends StatelessWidget {
  final String userId;
  MessageOfferScreen({Key? key, required this.userId}) : super(key: key);
  TextEditingController messageController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<CompanyHomeCubit, CompanyHomeStates>(
      listener: (context, state) {
        if (state is CompanySendOfferToUserSuccessState) {
          SystemChannels.textInput.invokeMethod('TextInput.hide').then((value) {
            CompanyOffersCubit.get(context).companyGetAllSentOffers();
            Navigator.pop(context);
            buildSuccessToast(
                context: context, title: "Done", description: state.msg);
          });
        } else if (state is CompanySendOfferToUserErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context, state) {
        CompanyHomeCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Offer',
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(color: myFavColor, fontSize: 20),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Company offer',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: myFavColor),
                    ),
                    mySizedBox(size: size, myHeight: 18),
                    buildFeedbackBox(
                      context: context,
                      minLines: 20,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return "Please enter your offer message";
                        }
                        return null;
                      },
                      hint: "Type your offer here...",
                      messageController: messageController,
                    ),
                    mySizedBox(size: size, myHeight: 120),
                    ConditionalBuilder(
                      condition: state is! CompanySendOfferToUserLoadingState,
                      builder: (context) => myMaterialButton(
                        context: context,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.companySendOfferToUser(
                              message: messageController.text,
                              uId: userId,
                            );
                          }
                        },
                        labelWidget: Text(
                          'Send Offer',
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
                    mySizedBox(size: size, myHeight: 18),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
