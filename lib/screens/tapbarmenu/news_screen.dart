// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_scale/models/news.dart';
import 'package:flutter_scale/screens/bottomnavmenu/new_item_horizontal.dart';
import 'package:flutter_scale/screens/bottomnavmenu/news_item_vertical.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/themes/color.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      color: Colors.blueAccent,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Last News",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                )),
            SizedBox(
              height: 220,
              child: Container(
                color: accent,
                child: FutureBuilder(
                  future: CallApi().getLastNews(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Not found!!"),
                      );
                    } else if (snapshot.connectionState == ConnectionState.done) {
                      List<NewsModel> news = snapshot.data;
                      return newsItemHorizontal(news);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "News",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: FutureBuilder(
                future: CallApi().getAllNews(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Not found!!"),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    List<NewsModel> news = snapshot.data;
                    return newsItemVertical(news);
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
