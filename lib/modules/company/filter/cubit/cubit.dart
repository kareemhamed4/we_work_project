import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:we_work/modules/company/filter/cubit/states.dart';

class CompanyFilterUsersCubit extends Cubit<CompanyFilterUsersStates> {
  CompanyFilterUsersCubit() : super(CompanyFilterUsersInitialState());

  static CompanyFilterUsersCubit get(context) => BlocProvider.of(context);

  String selectedExperience = "All";
  List<String> experienceList = [
    "All",
    "No Experience",
    "less than year",
    "1 year",
    "2-3 year",
    "more than 10 years"
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

  String selectedJobType = "All";
  String selectedPosition = "All";
}
