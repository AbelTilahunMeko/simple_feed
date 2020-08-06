import 'package:flutter_form_bloc/flutter_form_bloc.dart';

get verificationField => TextFieldBloc(
  name: "codeVerification",
  validators: [
    CodeValidators.checkValueNotEmpty,
    CodeValidators.checkValueNotTooShort,
  ],
);

class CodeValidators {
  static String checkValueNotEmpty(String value){
    if(value.isEmpty){
      return "This feild can't be empty";
    }
    return null;
  }

  static String checkValueNotTooShort(String value){
    if(value.length<6){
      return "The value is too short";
    }
    return null;
  }
}