import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  String iconPath;
  String title;
  double? imageHeight = 20;
  double? imageWidth = 20;
  Item({
    super.key,
    required this.iconPath,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
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
          children: [
            const SizedBox(
              width: 15,
            ),
            Image.asset(iconPath, width: imageWidth, height: imageHeight),
            const SizedBox(
              width: 15,
            ),
            Text(title),
            const Flexible(
                child: SizedBox(
              width: double.infinity,
            )),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 18,
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
