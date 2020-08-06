import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:simple_feed_app/bloc/forms/phone_number_form/feild.dart';

import '../../firebase_auth_bloc.dart';

class PhoneNumberFormBloc extends FormBloc <String, String>{
  final TextFieldBloc phoneNumberValidator;
  PhoneNumberFormBloc(): phoneNumberValidator=phoneNumberField{
    addFieldBloc(
        fieldBloc: phoneNumberValidator
    );
  }
  @override
  void onSubmitting() async {
    String phoneNumber;
    
    if (phoneNumberValidator.value.startsWith("251")) {
      phoneNumber = phoneNumberValidator.value;
    } else if (phoneNumberValidator.value
        .startsWith("09")) {
      phoneNumber = phoneNumberValidator.value
          .replaceFirst("09", "2519");
    } else if (phoneNumberValidator.value
        .startsWith("9")) {
      phoneNumber = "251" + phoneNumberValidator.value;
    }

    FirebaseAuthBloc.instance.phoneNumber = "+" + phoneNumber;
    try{
      FirebaseAuthBloc.instance.sendVerificationCode();
    }catch (e){
      emitFailure(failureResponse: e.toString());
    }

  }

}