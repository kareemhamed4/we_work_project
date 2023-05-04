import 'package:cupertino_radio_choice/cupertino_radio_choice.dart';
import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:we_work/shared/components/custom_button.dart';

class CompanyFilter extends StatefulWidget {
  @override
  State<CompanyFilter> createState() => _CompanyFilterState();
}

class _CompanyFilterState extends State<CompanyFilter> {
   String _verticalGroupValueExperience="Cairo in Egypt";
  List <String> Experience=["No experiness","less than year","1 year","2-3 year","more than 10 years"];
 String _verticalGroupValue="Cairo in Egypt";
 String _verticalGroupValueTypeofworkplace="onsite";
 List<String> _statusTypeofworkplace=["onsite","Remotly"];
 List <String> _statusLocation=["Cairo in Egypt","Alex in Egypt","mansoura in Egypt ","In other country"];
  SfRangeValues _values = SfRangeValues(120, 300);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Filter",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  SingleChildScrollView(
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text("Location",style: TextStyle(color:  Color(0xff649344)),),

                RadioGroup<String>.builder(
                  fillColor:Color(0xff649344) ,
                  groupValue: _verticalGroupValue,
                  onChanged: (value) => setState(() {
                    _verticalGroupValue = value!;
                  }),
                  items: _statusLocation,
                  itemBuilder: (item) => RadioButtonBuilder(
                    item,
                  ),
                ),
                Divider(color: Colors.grey,),
                Text("Type of workplace",style: TextStyle(color:  Color(0xff649344)),),
                RadioGroup<String>.builder(
                  fillColor:Color(0xff649344) ,
                  groupValue: _verticalGroupValueTypeofworkplace,
                  onChanged: (value) => setState(() {
                    _verticalGroupValueTypeofworkplace = value!;
                  }),
                  items: _statusTypeofworkplace,
                  itemBuilder: (item) => RadioButtonBuilder(
                    item,
                  ),
                ),
                Divider(color: Colors.grey,),

                Text("Job type",style: TextStyle(color:  Color(0xff649344)),),
                SizedBox(height: 10,),
                CupertinoRadioChoice(
                  selectedColor: Color(0xff649344),
                    choices: {
                      'Full time' : 'Full time',
                      'part time' : 'part time',
                      'intership': 'intership',
                      'project based':'project based'
                    },
                    onChange: (selectedGender) {},
                    initialKeyValue: 'Full time'),
                SizedBox(height: 10,),

                Divider(color: Colors.grey,height: 10,),
                Text("Job type",style: TextStyle(color:  Color(0xff649344)),),
                SizedBox(height: 10,),

                CupertinoRadioChoice(
                    selectedColor: Color(0xff649344),
                    choices: {
                      'Senior' : 'Senior',
                      'junior' : 'junior',
                      'manager': 'manager',
                      'Leader':'Leader'
                    },
                    onChange: (selectedGender) {},
                    initialKeyValue: 'Senior'),



                SizedBox(height: 10,),
                Divider(color: Colors.grey,height: 10,),
                SizedBox(height: 10,),
                Text("Salary",style: TextStyle(color:  Color(0xff649344)),),
    SfRangeSlider(

      inactiveColor:  Colors.grey,
    activeColor:Color(0xff649344) ,
    min: 10,
    max: 500,
    enableIntervalSelection: true,
    shouldAlwaysShowTooltip: true,

    showDividers: false,
    values: _values,
    interval:40,
    showTicks: false,
    showLabels: false,
    enableTooltip: false,

    minorTicksPerInterval: 1,
    onChanged: (SfRangeValues values) {
      setState(() {
        _values = values;
      });
    }),
            Divider(color: Colors.grey,height: 10,),
                Text("Experience",style: TextStyle(color:  Color(0xff649344)),),

                RadioGroup<String>.builder(
                  fillColor:Color(0xff649344) ,
                  groupValue:_verticalGroupValueExperience  ,
                  onChanged: (value) => setState(() {
                    _verticalGroupValueExperience  = value!;
                  }),
                  items: Experience ,
                  itemBuilder: (item) => RadioButtonBuilder(
                    item,
                  ),
                ),
                Divider(color: Colors.grey,),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all( 8),
                      child: CustomButton(
                        onPressed: () {
                          //Navigator.push( context,MaterialPageRoute(builder: (context) =>   ApplicateDetails()));

                        },
                        name: 'Reset',
                        buttonColorName: Color(0xff649344),
                        buttonColor: Colors.green.shade200,
                        buttonHeight: 60,

                        buttonNameSize: 16, buttonWidth:  130,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all( 8),
                        child: CustomButton(
                          onPressed: () {
                            //Navigator.push( context,MaterialPageRoute(builder: (context) =>   ApplicateDetails()));

                          },
                          name: 'Apply',
                          buttonColorName: Colors.white,
                          buttonColor: Color(0xff649344),
                          buttonHeight: 60,

                          buttonNameSize: 16,
                          buttonWidth:  double.infinity,
                        ),
                      ),
                    ),
                  ],
                ),
 
            ]

          ),
          ),
        ),
      ),
    );
  }
}
