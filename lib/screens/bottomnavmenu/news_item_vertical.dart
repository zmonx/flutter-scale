// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_scale/models/news.dart';

Widget newsItemVertical(List<NewsModel> news) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: news.length,
    itemBuilder: (context, index) {
      NewsModel newsModel = news[index];

      return ListTile(
        leading: Image.network(newsModel.imageurl),
        title: Text(
          newsModel.topic,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          newsModel.detail,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/newsdetail',
            arguments: {'id': newsModel.id},
          );
        },
      );
    },
  );
}
