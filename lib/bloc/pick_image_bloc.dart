import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_feed_app/bloc/feed/bloc.dart';

class PickImageWithBloc extends Cubit<File> {
  PickImageWithBloc([File file]) : super(file);

  final picker = ImagePicker();
  File _image;
  FeedBloc _feedBloc = FeedBloc();
  Future<File> getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        maxWidth: 400,
        maxHeight: 400,
        imageQuality: 50);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      _image = null;
    }

    //I added the image file here coz we changed the way we send data to DB
    //So when ever an image is picked i just attach the value here and
    // not pass it all over the place.
    _feedBloc.imageFile = _image;

    emit(_image);

    return _image;
  }
}
