import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:simple_feed_app/bloc/forms/post_form/post_form_bloc.dart';
import 'package:simple_feed_app/bloc/pick_image_bloc.dart';
import 'package:simple_feed_app/commons/snackbar_widget.dart';
import 'package:simple_feed_app/config/theme.dart';

class AddFeedPage extends StatefulWidget {
  @override
  _AddFeedPageState createState() => _AddFeedPageState();
}

class _AddFeedPageState extends State<AddFeedPage> {
  bool _imageLoaded = false;
  File _imageFile;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  PickImageWithBloc _imageWithBloc = PickImageWithBloc();
  final bloc = FeedPostFromBloc();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

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
              onPressed: () async {
                FocusScope.of(context).requestFocus(FocusNode());
                if (_imageFile == null) {
                  SnackBarWidget().displaySnackBar(
                      context, _scaffoldKey, "Please attach image");
                } else {
                  SnackBarWidget()
                      .displaySnackBar(context, _scaffoldKey, "Uploading");
                  bloc.submit();
                  _scaffoldKey.currentState.hideCurrentSnackBar();
                  SnackBarWidget().displaySnackBar(
                      context, _scaffoldKey, "Succesfully Done");
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
      body: ListView(
        children: <Widget>[
          StreamBuilder(
            stream: _imageWithBloc,
            builder: (context, AsyncSnapshot<File> snapshot) {
              if (snapshot.data != null) {
                _imageFile = File(snapshot.data.path);

                return Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                      child: Image.file(File(snapshot.data.path)),
                    ),
                    Align(
                      child: IconButton(
                        icon: Icon(
                          Icons.camera_alt,
                          color: Pallet.primaryColor,
                        ),
                        onPressed: () {
                          _imageWithBloc.getImage();
                        },
                      ),
                      alignment: Alignment.topLeft,
                    )
                  ],
                );
              }
              {
                return Container(
                  height: _imageLoaded
                      ? 100
                      : MediaQuery.of(context).size.height / 4,
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt,
                      color: Pallet.primaryColor,
                    ),
                    onPressed: () {
                      _imageWithBloc.getImage();
                    },
                  ),
                );
              }
            },
          ),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Card(
              child: TextFieldBlocBuilder(
                maxLines: 10,
                decoration: InputDecoration(hintText: "Whats happening?"),
                textFieldBloc: bloc.captionValidator,
              ),
            ),
          )
        ],
      ),
    );
  }
}
