import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_feed_app/config/theme.dart';
import 'package:simple_feed_app/pages/home_page.dart';
import 'package:simple_feed_app/pages/sign_in_page.dart';
import 'package:simple_feed_app/util/dio_provider.dart';

import 'commons/loading_widget.dart';


void main() {
  runApp(GetMaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Pallet.materialColor,
        primaryColor: Pallet.materialColor,
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
