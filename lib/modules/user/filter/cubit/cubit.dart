import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:we_work/modules/user/filter/cubit/states.dart';

class UserFilterJobsCubit extends Cubit<UserFilterJobsStates> {
  UserFilterJobsCubit() : super(UserFilterJobsInitialState());

  static UserFilterJobsCubit get(context) => BlocProvider.of(context);

  String selectedExperience = "All";
  List<String> experienceList = [
    "All",
    "No Experience",
    "less than year",
    "1 year",
    "2-3 year",
    "more than 10 years"
  ];

  String selectedWorkPlace = "All";
  List<String> workPlaceList = [
    "All",
    "onSite",
    "Remotely",
  ];

  String selectedCountry = "All";
  List<String> countriesList = [
    "All",
    "Egypt",
    "Palestine"
  ];

  String selectedCity = "All";
  List<String> citiesList = [
    "All",
    "Cairo",
    "Alex"
  ];

  SfRangeValues valuesOfPrice = const SfRangeValues(0, 30000);

  dynamic selectedMinSalary = 0;
  dynamic selectedMaxSalary = 30000;
  String selectedJobType = "All";
  String selectedPosition = "All";
}
