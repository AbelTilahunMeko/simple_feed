import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget{
  final double height;
  LoadingWidget({this.height});

  Widget _buildLoading(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/loading_gif.gif", height: height==null?170:height,)
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return _buildLoading(context);
  }
}
