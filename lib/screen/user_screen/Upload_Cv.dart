import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/custom_button.dart';
import 'applicate_Details.dart';

class UploadCv extends StatefulWidget {
  @override
  State<UploadCv> createState() => _UploadCvState();
}
List <double> cutList=[16,10];
String? nameFile;
bool pdfIsUplod=false ;

class _UploadCvState extends State<UploadCv> {
  TextEditingController? textMessageController;
  String? messageEntrer;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Upload Cv      ",
            style: GoogleFonts.roboto(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 15,left: 15,top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Add a certification to apply to a job",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 15,),
              Container(
                   //padding of outer Container
                  child: DottedBorder(

                    color: Color(0xff649344), //color of dotted/dash line
                    strokeWidth: 1, //thickness of dash/dots
                    dashPattern: cutList,
                    //dash patterns, 10 is dash width, 6 is space width
                    child: Container(
                        //inner container
                        height:83, //height of inner container
                        width: double
                            .infinity, //width to 100% match to parent container.
                        color: Colors.white,
                      child:   GestureDetector(
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf'],
                          );
                          if (result != null) {
                            PlatformFile file = result.files.first;

                            setState(() {
                              nameFile=file.name;
                              pdfIsUplod=true;
                              cutList=[1.0];
                            });

                          }
                        },
                        child:pdfIsUplod? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                             children: [
                              Image.asset("assets/image/pdf 1.png"),
                             SizedBox(width: 10,)
                             , Text(nameFile!)
                            ],
                          ),
                        ):Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Icon(Icons.cloud_upload_outlined,color:Color(0xff649344) ,),
                    SizedBox(width: 10,)
                    , Text("upload your cv",style: TextStyle(color:Color(0xff649344) ),)
                    ],
                  ),
                      ),//background color of inner container
                        ),
                  )

              ),
              SizedBox(height: 15,),
              Text(
                "Information",
                style: TextStyle(color: Colors.grey),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  border: Border.all(
                    color: Colors.grey.shade300,
                  ),
                ),
                height:300,
                width: double.infinity,
                child: TextField(
                  controller: textMessageController,
                  keyboardType: TextInputType.multiline,
                  textCapitalization: TextCapitalization.sentences,
                  minLines: 1,
                  maxLines: null,
                  onChanged: ((value) {
                    setState(() {
                      messageEntrer = value;
                    });
                  }),
                  decoration: InputDecoration(
                    hintText: "Why you see this job Suitable for you?",
                    hintMaxLines: 1,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                    hintStyle: TextStyle(
                      fontSize: 16,
                    ),
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
              ),



              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: CustomButton(
                  onPressed: () {

                   Navigator.push( context,MaterialPageRoute(builder: (context) =>   ApplicateDetails()));

                  },
                  name: 'Apply',
                  buttonColorName: Colors.white,
                  buttonColor: Color(0xff649344),
                  buttonHeight: 60,
                  buttonWidth: double.infinity,
                  buttonNameSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
