import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:we_work/shared/styles/colors.dart';

Widget myTextFormField({
  required BuildContext context,
  TextEditingController? controller,
  TextInputType? type,
  bool? isPassword,
  VoidCallback? onTap,
  ValueChanged<String>? onChange,
  String? Function(String?)? validate,
  ValueChanged<String>? onSubmit,
  Widget? suffixIcon,
  Widget? prefixIcon,
  Widget? icon,
  int? maxLength,
  int? maxLength2,
  String? hint,
}) =>
    TextFormField(
      obscuringCharacter: '●',
      controller: controller,
      keyboardType: type,
      obscureText: isPassword ?? false,
      onTap: onTap,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      validator: validate,
      maxLength: maxLength,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength2),
      ],
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: 16.sp, color: myFavColor6),
      decoration: InputDecoration(
        hintText: hint ?? '',
        hintStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontSize: 16.sp, color: myFavColor4),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        icon: icon,
      ),
    );

Widget myMaterialButton({
  required BuildContext context,
  required Function onPressed,
  Widget? labelWidget,
  bool isEnabled = true,
  Color? bgColorForNotEnabled,
}) =>
    MaterialButton(
      onPressed: () {
        onPressed();
      },
      color: isEnabled ? myFavColor : bgColorForNotEnabled ?? myFavColor3,
      minWidth: double.infinity,
      height: 50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: labelWidget,
    );

// ignore: non_constant_identifier_names
Future NavigateToReb({
  required BuildContext context,
  required Widget widget,
}) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);

// ignore: non_constant_identifier_names
Future NavigateTo({
  required BuildContext context,
  required Widget widget,
}) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Widget myDivider({double? paddingValue,double? height}) => Padding(
      padding: EdgeInsets.only(
        right: paddingValue ?? 12,
        left: paddingValue ?? 12,
        top: height ??0,
        bottom: height ??0,
      ),
      child: Container(
        width: double.infinity,
        color: Colors.grey[300],
        height: 1,
      ),
    );

Widget myTextButton({
  required BuildContext context,
  required String label,
  required Function onPressed,
}) =>
    TextButton(
      style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          alignment: Alignment.center
      ),
      onPressed: () {
        onPressed();
      },
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontSize: 16.sp)
            .copyWith(color: myFavColor),
      ),
    );

Widget buildFeedbackBox({
  required BuildContext context,
  required String hint,
  int? minLines,
  String? Function(String?)? validate,
  required TextEditingController messageController,
  ValueChanged<String>? onChange,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(5)),
      border: Border.all(
        color: Colors.grey.shade300,
      ),
    ),
    width: double.infinity,
    child: TextFormField(
      controller: messageController,
      validator: validate,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      minLines: minLines ?? 10,
      maxLines: null,
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hint,
        hintMaxLines: 1,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        hintStyle: Theme.of(context).textTheme.bodySmall,
        fillColor: Colors.white,
        filled: false,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: .2,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
          borderSide: const BorderSide(
            color: Colors.white,
            width: 0.2,
          ),
        ),
      ),
    ),
  );
}

void buildSuccessToast({
  required BuildContext context,
  required String title,
  required String description,
}) =>
    CherryToast.success(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: myFavColor6, fontSize: 16),
      ),
      description: Text(
        description,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: myFavColor6, fontSize: 12),
      ),
      animationType: AnimationType.fromRight,
      animationDuration: const Duration(milliseconds: 1000),
      autoDismiss: true,
    ).show(context);

void buildErrorToast({
  required BuildContext context,
  required String title,
  required String description,
  bool? showTitle,
}) =>
    CherryToast.error(
      displayTitle: showTitle ?? true,
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: myFavColor6, fontSize: 16),
      ),
      description: Text(
        description,
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: myFavColor6, fontSize: 12),
      ),
      animationType: AnimationType.fromTop,
      animationDuration: const Duration(milliseconds: 1000),
      autoDismiss: true,
    ).show(context);

void showProgressIndicator(BuildContext context) {
  AlertDialog alertDialog = AlertDialog(
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(myFavColor),
        ),
      ),
    ),
  );
  showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.2),
      barrierDismissible: false,
      builder: (context) {
        return alertDialog;
      });
}

void showMyDialog({
  required BuildContext context,
  IconData? icon,
  required Function onConfirm,
  Widget? contentWidget,
  Widget? titleWidget,
  Key? formKey,
  String? confirmText,
  String? cancelText,
  bool isCancelButton = true,
}) {
  showDialog<String>(
    context: context,
    builder: (dialogContext) => Form(
      key: formKey,
      child: Center(
        child: SingleChildScrollView(
          child: AlertDialog(
            icon: Icon(
              icon ?? Icons.info_outline,
              color: myFavColor8,
            ),
            backgroundColor: Colors.white,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            title: titleWidget ?? const SizedBox(),
            content: contentWidget ?? const SizedBox(),
            contentPadding: contentWidget != null ? const EdgeInsets.all(8): EdgeInsets.zero,
            actions: <Widget>[
              if(isCancelButton)
                MaterialButton(
                  color: myFavColor2,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: Text(
                    cancelText ?? "Cancel",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: myFavColor, fontSize: 20),
                  ),
                ),
              MaterialButton(
                color: myFavColor,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                onPressed: () async{
                  await onConfirm();
                },
                child: Text(
                  confirmText ?? "Confirm",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}