
import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class PickImageWithBloc extends Cubit<File> {


  PickImageWithBloc([File file]):super(file);

  final picker = ImagePicker();
  File _image;


  Future<File> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, maxWidth: 400, maxHeight: 400, imageQuality: 50);
    if(pickedFile!=null){
      _image = File(pickedFile.path);
    }else{
      _image = null;
    }
    emit(_image);

    return _image;
  }
}
