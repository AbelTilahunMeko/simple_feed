import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget{
  Widget _buildLoading(context){
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/loading_gif.gif", height: 170,)
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
