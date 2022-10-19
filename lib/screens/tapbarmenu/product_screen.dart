// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_scale/models/product_model.dart';
import 'package:flutter_scale/screens/tapbarmenu/products_item_list.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/themes/color.dart';


var refreshKey =  GlobalKey<RefreshIndicatorState>();


class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder(
          future: CallApi().getProducts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Not found!!"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<ProductsModel> news = snapshot.data;
              return productsItemList(news);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/addproduct");
        },
        child: Icon(Icons.add),
        backgroundColor: accent,
        splashColor: primary_light,
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
