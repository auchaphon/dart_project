import 'package:dart_app/widgets/login/index.dart';
import 'package:dart_app/widgets/home/index.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      routes: {
        Home.routeName: (context) => Home(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Login(),
        // child: Container(
        //   color: Colors.white,
        //   width: MediaQuery.of(context).size.width,
        //   height: MediaQuery.of(context).size.height,
        //   margin: EdgeInsets.only(left: 20, right: 20),
        // ),
      ),
    );
  }
}
