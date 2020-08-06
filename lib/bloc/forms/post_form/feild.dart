import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:simple_feed_app/bloc/forms/verification_form/feild.dart';

get captionFormValidator => TextFieldBloc(
  name: "postForm",
  validators: [
    CodeValidators.checkValueNotEmpty
  ]
);
