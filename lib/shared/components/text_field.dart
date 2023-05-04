import 'package:flutter/material.dart';

class Custom_TextFormfield extends StatelessWidget {
  String? label_Text;
  bool? scure;
  Widget? icon_suffix;
  bool? is_suffixIcon_password;
  bool? is_suffixIcon;
  Function(String)? onChanged;
  Custom_TextFormfield(
      {this.scure = false,
      this.label_Text,
      this.onChanged,
      this.is_suffixIcon = false,
      this.is_suffixIcon_password = false,
      this.icon_suffix});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: scure!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'opsss';
        }
      },
      onChanged: onChanged,
      decoration: InputDecoration(
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Color(0xff649344)),
        ),
        labelText: label_Text,
        labelStyle: new TextStyle(color: Colors.grey),
        suffixIcon: is_suffixIcon_password == true
            ? IconButton(
                icon: Icon(
                    scure == true ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  scure == scure!;
                },
              )
            : is_suffixIcon == true
                ? icon_suffix
                : null,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xff649344))),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
