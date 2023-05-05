import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:we_work/modules/user/applicate_details/applicate_google_details.dart';
import 'package:we_work/modules/user/applicate_details/applicate_microsoft_details.dart';
import 'package:we_work/shared/components/components.dart';
import 'package:we_work/shared/styles/colors.dart';

class UploadCv extends StatefulWidget {
  final int index;
  const UploadCv({super.key, required this.index});

  @override
  State<UploadCv> createState() => _UploadCvState();
}

List<double> cutList = [16, 10];
String? nameFile;
bool pdfIsUpload = false;

class _UploadCvState extends State<UploadCv> {
  TextEditingController? textMessageController;
  String? messageEnter;
  @override
  Widget build(BuildContext context) {
    int index = widget.index;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Upload CV',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: myFavColor, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add a certification to apply to a job",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(
              height: 41,
            ),
            DottedBorder(
              color: const Color(0xff649344), //color of dotted/dash line
              strokeWidth: 1, //thickness of dash/dots
              dashPattern: cutList,
              //dash patterns, 10 is dash width, 6 is space width
              child: Container(
                //inner container
                height: 83, //height of inner container
                width:
                    double.infinity, //width to 100% match to parent container.
                color: Colors.white,
                child: GestureDetector(
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['pdf'],
                    );
                    if (result != null) {
                      PlatformFile file = result.files.first;

                      setState(() {
                        nameFile = file.name;
                        pdfIsUpload = true;
                        cutList = [1.0];
                      });
                    }
                  },
                  child: pdfIsUpload
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.asset("assets/image/pdf 1.png"),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(nameFile!)
                            ],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              color: myFavColor,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "upload your cv",
                              style: TextStyle(color: myFavColor),
                            )
                          ],
                        ),
                ), //background color of inner container
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Text(
              "Information",
              style: Theme.of(context).textTheme.bodyText2,
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: buildFeedbackBox(
                context: context,
                hint: "Why you see this job Suitable for you?",
                messageController: textMessageController!,
              ),
            ),
            const SizedBox(
              height: 41,
            ),
            myMaterialButton(
              context: context,
              onPressed: () {
                if (index == 0) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ApplicateDetailsForGoogle()));
                }
                if (index == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ApplicateDetailsForMicrosoft()));
                }
              },
              labelWidget: Text(
                'Send',
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
