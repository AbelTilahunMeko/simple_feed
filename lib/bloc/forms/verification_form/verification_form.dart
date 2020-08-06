import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:simple_feed_app/bloc/forms/verification_form/feild.dart';
import 'package:simple_feed_app/util/logger.dart';

import '../../firebase_auth_bloc.dart';

class VerificationFormBloc extends FormBloc<String, String>{
  final TextFieldBloc verificationFieldBloc;
  VerificationFormBloc(): verificationFieldBloc = verificationField{
    addFieldBlocs(
      fieldBlocs: [verificationFieldBloc],
    );
  }
  @override
  void onSubmitting() {
    // TODO: implement onSubmitting
//    logger.d("THe verification code in " + verificationFieldBloc.value.toString());
    try{
      FirebaseAuthBloc.instance.verifyCode(verificationFieldBloc.value);
      emitSuccess(canSubmitAgain: false);
    }catch(e){
      emitFailure(failureResponse: e.toString());
    }

  }

}