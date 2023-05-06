import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:we_work/shared/styles/colors.dart';

Widget myTextFormField({
  required BuildContext context,
  TextEditingController? controller,
  TextInputType? type,
  bool? isPassword,
  Function? onTap,
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
      onTap: () {
        onTap;
      },
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
      validator: validate,
      maxLength: maxLength,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength2),
      ],
      style: Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 18),
      decoration: InputDecoration(
        hintText: hint ?? '',
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(fontSize: 16, color: myFavColor4),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
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

Widget myDivider({double? paddingValue}) => Padding(
      padding: EdgeInsets.only(
        right: paddingValue ?? 12,
        left: paddingValue ?? 12,
        top: 0,
        bottom: 0,
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
      onPressed: () {
        onPressed();
      },
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontSize: 16)
            .copyWith(color: myFavColor),
      ),
    );

Widget buildFeedbackBox({
  required BuildContext context,
  required String hint,
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
    child: TextField(
      controller: messageController,
      keyboardType: TextInputType.multiline,
      textCapitalization: TextCapitalization.sentences,
      minLines: 1,
      maxLines: null,
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hint,
        hintMaxLines: 1,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        hintStyle: Theme.of(context).textTheme.caption,
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

Widget mySizedBox({
  required Size size,
  double? myHeight,
  double? myWidth,
}) =>
    SizedBox(
      height: myHeight != null ? size.height * myHeight / size.height : 0,
      width: myWidth != null ? size.width * myWidth / size.width : 0,
    );