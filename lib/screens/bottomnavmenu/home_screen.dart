// ignore_for_file: prefer_const_constructors, avoid_print, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/tapbarmenu/news_screen.dart';
import 'package:flutter_scale/screens/tapbarmenu/product_screen.dart';
import 'package:flutter_scale/screens/tapbarmenu/store_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            bottom: TabBar(tabs: [
              Tab(
                text: "News",
                icon: Icon(Icons.newspaper_outlined),
              ),
              Tab(
                text: "Product",
                icon: Icon(Icons.sell),
              ),
              Tab(
                text: "Store",
                icon: Icon(Icons.store),
              ),
            ]),
            title: Text(""),
          ),
        ),
        body: TabBarView(
          children: [
            NewsScreen(),
            ProductScreen(),
            StoreScreen(),
          ],
        ),
      ),
    );
  }
}
