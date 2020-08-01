import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_feed_app/bloc/bloc.dart';
import 'package:simple_feed_app/config/theme.dart';
import 'package:simple_feed_app/widgets/loading_widget.dart';
import 'package:simple_feed_app/widgets/snackbar_widget.dart';

class AddFeedPage extends StatefulWidget {
  @override
  _AddFeedPageState createState() => _AddFeedPageState();
}

class _AddFeedPageState extends State<AddFeedPage> {
  bool _imageLoaded = false;
  File _imageFile;
  TextEditingController _captionController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Pallet.CodGrayTextColor,
          ),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 20, top: 10, bottom: 10),
            child: RaisedButton(
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                if(_captionController.text.isEmpty || _imageFile == null) {
                  SnackBarWidget().displaySnackBar(context, _scaffoldKey,
                      "Please feel the required feild.");
                }else{
                  bloc.uploadCompleteController.sink.add(true);
                  bloc.uploadFeedToDB(_imageFile, _captionController.text);
                  _captionController.clear();
                }
              },
              color: Pallet.primaryColor,
              child: Text(
                "Post",
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: bloc.uploadCompleteController.stream,
        builder: (context, snapshot){
          return snapshot.data==null || snapshot.data == false? ListView(
            children: <Widget>[
              Visibility(
                visible: snapshot.data!=null && snapshot.data == false,
                child: Center(child: Text("You have sucessfully uploaded your Feed\n Go Back", textAlign: TextAlign.center, style: TextStyle(fontSize: 18,),),)
              ),
              StreamBuilder(
                stream: bloc.pickImageController.stream,
                builder: (context, AsyncSnapshot<File> snapshot) {
                  if (snapshot.data != null) {
                    _imageFile = File(snapshot.data.path);

                    return Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/3,
                          child: Image.file(File(snapshot.data.path)),
                        ),
                        Align(

                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Pallet.primaryColor,
                            ),
                            onPressed: () {
                              bloc.pickImage();
                            },
                          ),
                          alignment: Alignment.topLeft,
                        )
                      ],
                    );
                  }
                  {
                    return Container(
                      height: _imageLoaded? 100: MediaQuery.of(context).size.height / 4,
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: Pallet.primaryColor,
                        ),
                        onPressed: () {
                          bloc.pickImage();
                        },
                      ),
                    );
                  }
                },
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Card(
                  child: TextFormField(
                    controller: _captionController,
                    maxLines: 10,
                    decoration: InputDecoration(hintText: "Whats happening?"),
                  ),
                ),
              )
            ],
          ):LoadingWidget();
        },
      ),
    );
  }
}
