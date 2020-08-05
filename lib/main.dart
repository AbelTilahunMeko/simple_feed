import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_feed_app/pages/home_page.dart';
import 'package:simple_feed_app/pages/sign_in_page.dart';
import 'package:simple_feed_app/util/dio_provider.dart';

import 'widgets/loading_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static Map<int, Color> color = {
    50: Color.fromRGBO(255, 92, 87, .1),
    100: Color.fromRGBO(255, 92, 87, .2),
    200: Color.fromRGBO(255, 92, 87, .3),
    300: Color.fromRGBO(255, 92, 87, .4),
    400: Color.fromRGBO(255, 92, 87, .5),
    500: Color.fromRGBO(255, 92, 87, .6),
    600: Color.fromRGBO(255, 92, 87, .7),
    700: Color.fromRGBO(255, 92, 87, .8),
    800: Color.fromRGBO(255, 92, 87, .9),
    900: Color.fromRGBO(255, 92, 87, 1),
  };

  final MaterialColor _materialColor = MaterialColor(0xffE9446A, color);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: _materialColor,
        primaryColor: _materialColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return FutureBuilder(
              future: DioProvider.instance.init(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) {
                  return Scaffold(
                    body: LoadingWidget(),
                  );
                }
                return HomePage();
              });
        } else {
          return SignInPage();
        }
      },
    ));
  }
}
