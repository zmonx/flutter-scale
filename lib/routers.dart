// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:flutter/material.dart';
import 'package:flutter_scale/models/news_detail.dart';
import 'package:flutter_scale/screens/addproduct/add_product_screen.dart';
import 'package:flutter_scale/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_scale/screens/drawermenu/about_screen.dart';
import 'package:flutter_scale/screens/drawermenu/contact_screen.dart';
import 'package:flutter_scale/screens/drawermenu/info_screen.dart';
import 'package:flutter_scale/screens/login/login_screen.dart';
import 'package:flutter_scale/screens/login/register_screen.dart';
import 'package:flutter_scale/screens/newsDetail/new_detail_screen.dart';
import 'package:flutter_scale/screens/updateproduct/update_product_screen.dart';
import 'package:flutter_scale/screens/welcome/welcome_screen.dart';

// create map variable to store route

Map<String, WidgetBuilder> routes = {
  '/welcome': (BuildContext) => WelcomeScreen(),
  '/dashboard': (BuildContext) => DashBoardScreen(),
  '/login': (BuildContext) => LoginScreen(),
  '/register': (BuildContext) => RegisterScreen(),
  '/newsdetail': (BuildContext) => NewsDetailScreen(),
  '/addproduct': (BuildContext) => AddProductScreen(),
  '/edtproduct': (BuildContext) => UpdateProductScreen(),
  //drawer
  '/contact': (BuildContext) => ContactScreen(),
  '/info': (BuildContext) => InfoScreen(),
  '/about': (BuildContext) => AboutScreen(),
};
