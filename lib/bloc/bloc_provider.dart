import 'package:flutter/cupertino.dart';

import 'bloc.dart';


// ignore: must_be_immutable
class BlocProvider extends InheritedWidget {
  final Widget child;
  BlocIn bloc = BlocIn();

  BlocProvider({@required this.child, key}) : super(child: child, key: key);

  static BlocIn of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(BlocProvider) as BlocProvider)
        .bloc;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }
}
