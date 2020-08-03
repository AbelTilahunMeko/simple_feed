
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class PickImageWithBloc {
  static PickImageWithBloc instance = PickImageWithBloc._();

  PickImageWithBloc._();

  final picker = ImagePicker();
  File _image;

  static final StreamController<File> _pickImageStreamController = StreamController
      .broadcast();
  StreamController<File> get pickImageController => _pickImageStreamController;

  void dispose() {
    _pickImageStreamController.close();
    instance = PickImageWithBloc._();
  }

  Future<File> getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, maxWidth: 400, maxHeight: 400, imageQuality: 50);
    if(pickedFile!=null){
      _image = File(pickedFile.path);
    }else{
      _image = null;
    }
    _pickImageStreamController.sink.add(_image);

    return _image;
  }
}
