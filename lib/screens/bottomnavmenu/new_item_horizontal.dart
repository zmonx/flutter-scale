// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_scale/models/news.dart';
import 'package:flutter_scale/themes/color.dart';

Widget newsItemHorizontal(List<NewsModel> news) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: news.length,
    itemBuilder: (context, index) {
      NewsModel newsModel = news[index];

      return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              '/newsdetail',
              arguments: {'id': newsModel.id},
            );
          },
          child: Card(
            child: Container(
              child: Column(
                children: [
                  Container(
                    height: 130,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(newsModel.imageurl),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          newsModel.topic,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          newsModel.detail,
                          style: TextStyle(
                            fontSize: 14,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
