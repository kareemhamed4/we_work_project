import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:we_work/modules/common/new_password/Change%20the%20password.dart';
import 'package:we_work/modules/common/otp/cubit/cubit.dart';
import 'package:we_work/modules/common/otp/cubit/states.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

//ignore: must_be_immutable
class ConfirmMessage extends StatelessWidget {
  final String email;
  ConfirmMessage({super.key,required this.email});
  var formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<UserVerifyOTPCubit,UserVerifyOTPStates>(
      listener: (context,state){
        if (state is UserVerifyOTPSuccessState) {
          NavigateTo(context: context, widget: ChangePassword(email: email));
        }
        if (state is UserVerifyOTPErrorState) {
          buildErrorToast(
            title: "Oops!",
            context: context,
            description: state.error,
          );
        }
      },
      builder: (context,state){
        UserVerifyOTPCubit cubit = BlocProvider.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Verify your email",
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: myFavColor),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    Image.asset(
                      'assets/image/Rectangle 3 (1).png',
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 62.h),
                    Text(
                      'Please enter 4 digit which send to your email',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 16.sp, height: 1.5),
                    ),
                    SizedBox(height: 58.h),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: PinCodeTextField(
                        appContext: context,
                        pastedTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(color: myFavColor,fontSize: 16),
                        autoFocus: true,
                        cursorColor: myFavColor,
                        keyboardType: TextInputType.phone,
                        cursorHeight: 28,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                        ],
                        length: 4,
                        obscureText: true,
                        obscuringCharacter: "●",
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(
                            color: myFavColor, fontSize: 35, height: 1),
                        animationType: AnimationType.scale,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                          fieldHeight: size.height * 48/812,
                          fieldWidth: size.width * 48/375,
                          borderWidth: 0.5,
                          activeColor: myFavColor4,
                          disabledColor: myFavColor4,
                          inactiveColor: myFavColor4.withOpacity(0.5),
                          inactiveFillColor: Colors.white,
                          activeFillColor: myFavColor4.withOpacity(0.1),
                          selectedColor: myFavColor,
                          selectedFillColor: myFavColor.withOpacity(0.2),
                        ),
                        animationDuration: const Duration(milliseconds: 300),
                        backgroundColor:
                        Theme.of(context).scaffoldBackgroundColor,
                        enableActiveFill: true,
                        onCompleted: (value) {
                          otpController.text = value;
                          debugPrint("Completed");
                        },
                        onChanged: (value) {
                          debugPrint(value);
                        },
                      ),
                    ),
                    SizedBox(height: 130.h),
                    ConditionalBuilder(
                      condition: state is! UserVerifyOTPLoadingState,
                      builder: (context) => myMaterialButton(
                        context: context,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.userVerifyOTP(
                              verificationCode: otpController.text,
                              email: email,
                            );
                          }
                        },
                        labelWidget: Text(
                          'Verify',
                          style: Theme.of(context).textTheme.labelLarge,
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
                    SizedBox(height: 40.h),
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
