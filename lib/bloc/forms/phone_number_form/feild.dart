import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:simple_feed_app/bloc/forms/verification_form/feild.dart';

get phoneNumberField => TextFieldBloc(
  name: "phoneNumber",
  validators: [
    CodeValidators.checkValueNotEmpty,
    PhoneNumberValidators.checkValueLengthTooLong,
    PhoneNumberValidators.checkValueLengthTooShort
  ]
);

class PhoneNumberValidators{
  static String checkValueLengthTooShort(String value){
    if(value.length<9){
      return "Phone number is too short";
    }
    return null;
  }
  static String checkValueLengthTooLong(String value){
    if(value.length >9){
      return "Phone number is too long";
    }
    return null;
  }
}
