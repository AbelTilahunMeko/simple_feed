
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PickImageWithBloc {
  File _image;
  final picker = ImagePicker();
  Future<File> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, maxWidth: 400, maxHeight: 400, imageQuality: 50);
    if(pickedFile!=null){
      _image = File(pickedFile.path);
    }else{
      _image = null;
    }
    return _image;
  }
}
