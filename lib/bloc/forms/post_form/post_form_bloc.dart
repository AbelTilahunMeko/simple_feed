import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:simple_feed_app/bloc/feed/bloc.dart';
import 'package:simple_feed_app/bloc/forms/post_form/feild.dart';

class FeedPostFromBloc extends FormBloc{
  FeedBloc feedBloc = FeedBloc();

  final TextFieldBloc captionValidator;
  FeedPostFromBloc(): captionValidator = captionFormValidator{
    addFieldBloc(
      fieldBloc: captionValidator
    );
  }

  @override
  void onSubmitting() async{
    // TODO: implement onSubmitting
    try{
      await feedBloc.uploadFeedToDB(captionValidator.value);
      emitSuccess(canSubmitAgain: true);
    }catch (e){
      emitFailure(failureResponse: e.toString());
    }

  }

}