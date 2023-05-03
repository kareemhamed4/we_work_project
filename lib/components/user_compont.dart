import 'package:flutter/material.dart';

class Item extends StatelessWidget{
 IconData icon;
  String title;
  @override
  Item({required this.icon,required this.title});
  Widget build(BuildContext context) {

     return Padding(
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
             Icon( icon,color: Color(0xff649344),),

             SizedBox(width: 15,),

             Text(title),
             Flexible(child: SizedBox(width:double.infinity,)),
             Icon( Icons.arrow_forward_ios,color: Colors.grey,size: 18,),

             SizedBox(width: 15,),
           ],

         ),

       ),
     );
  }

}