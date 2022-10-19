// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_scale/models/news_detail.dart';
import 'package:flutter_scale/services/rest_api.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({super.key});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  NewsDetailModel? _dataNews;

  readNewsDetail(String id) async {
    try {
      var response = await CallApi().getNewsDetail(id);
      setState(() {
        _dataNews = response!;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    //get id from navigator.pushnamed

    final Map args = ModalRoute.of(context)!.settings.arguments as Map;

    readNewsDetail(args['id']);

    return Scaffold(
      appBar: AppBar(
        title: Text(_dataNews?.topic ?? "..."),
      ),
      body: ListView(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(_dataNews?.imageurl ?? "..."), fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              _dataNews?.topic ?? "...",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              _dataNews?.detail ?? "...",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Publish : ${_dataNews?.createdAt.toString() ?? "..."}",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
