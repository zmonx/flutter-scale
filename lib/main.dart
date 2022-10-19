// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_scale/routers.dart';
import 'package:flutter_scale/themes/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

var userStep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  userStep = sharedPreferences.getInt("userStep");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      routes: routes,
      initialRoute: userStep == 1 ? '/dashboard' : '/welcome',
    );
  }
}
