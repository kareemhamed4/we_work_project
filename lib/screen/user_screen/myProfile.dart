import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/user_compont.dart';

class MyProfile extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final urlImage =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

    return Scaffold(
appBar: AppBar(
  title: Center(
    child: Text(
      "My Profile",
      style: GoogleFonts.roboto(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),
),
   body: SingleChildScrollView(
     child: Padding(
       padding: const EdgeInsets.all(8.0),
       child: Column(
          children: [
           Center(child: CircleAvatar(radius:50, backgroundImage: NetworkImage(urlImage) )),

            Text("Manar Maher",style: TextStyle(fontSize: 20,fontWeight:FontWeight.w500),),
            SizedBox(height:8),
Text( "UI,Ux designer",style: TextStyle(color: Colors.grey),)

 ,
            Item(icon:Icons.local_activity_outlined, title: 'Activity',),
            Item(icon:Icons.add, title: 'Skills',),
            Item(icon:Icons.location_on_outlined, title: 'Location',),
            Item(icon:Icons.school_outlined, title: 'Education',),
            Item(icon:Icons.g_translate, title: 'Language',),
            Item(icon:Icons.file_copy_outlined, title: 'Cv',),

     Padding(
       padding: const EdgeInsets.only(top: 10),
       child: Container(

         decoration: BoxDecoration(
           borderRadius: BorderRadius.all(Radius.circular(5)),
           border: Border.all(color: Colors.grey.shade300,),

         ),

         height:60 ,

         width: double.infinity,

         child: Row(

           children: [




             SizedBox(width: 15,),
             Icon(Icons.power_settings_new_rounded,color: Colors.red,),

             SizedBox(width: 15,),

             Text("Logout",style: TextStyle(color: Colors.red),),
             Flexible(child: SizedBox(width:double.infinity,)),
             Icon( Icons.arrow_forward_ios,color: Colors.grey,size: 18,),

             SizedBox(width: 15,),
           ],

         ),

       ),
     ),

         ],
       ),
     ),
   ),
 );
  }

}