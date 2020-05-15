import 'package:appfirebase/classes/auth_firebase.dart';
import 'package:appfirebase/pages/login_page.dart';
import 'package:appfirebase/pages/root_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: RootPage(authFirebase: new AuthFirebase(),),
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
    );
  }
}