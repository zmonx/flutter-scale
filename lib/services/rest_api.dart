// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter_scale/models/news.dart';
import 'package:flutter_scale/models/news_detail.dart';
import 'package:flutter_scale/models/product_model.dart';
import 'package:flutter_scale/utils/constants.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_scale/models/userModel.dart';

class CallApi {
  //set Header
  _setHeader() => {'Content-Type': 'application/json', 'Accept': 'application/json'};

//function login

  loginApi(data) async {
    return await http.post(
      Uri.parse(baseUrl + 'login'),
      headers: _setHeader(),
      body: jsonEncode(data),
    );
  }

  registerApi(data) async {
    return await http.post(
      Uri.parse(baseUrl + 'register'),
      headers: _setHeader(),
      body: jsonEncode(data),
    );
  }

  Future<List<NewsModel>?> getAllNews() async {
    final response = await http.get(
      Uri.parse(baseUrl + 'news'),
      headers: _setHeader(),
    );

    if (response.body != null) {
      return newsModelFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<List<NewsModel>?> getLastNews() async {
    final response = await http.get(
      Uri.parse(baseUrl + 'lastnews'),
      headers: _setHeader(),
    );

    if (response.body != null) {
      return newsModelFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<NewsDetailModel?> getNewsDetail(String id) async {
    final response = await http.get(
      Uri.parse(baseUrl + 'news/' + id),
      headers: _setHeader(),
    );

    if (response.body != null) {
      return newsDetailModelFromJson(response.body);
    } else {
      return null;
    }
  }

  //----------------------------
  // CRUD Product
  //----------------------------

// get product

  Future<List<ProductsModel>?> getProducts() async {
    final response = await http.get(
      Uri.parse(baseUrl + 'products'),
      headers: _setHeader(),
    );

    if (response.body != null) {
      return productsModelFromJson(response.body);
    } else {
      return null;
    }
  }

// create product

  Future<bool> createProducts(ProductsModel data) async {
    final response = await http.post(
      Uri.parse(baseUrl + 'products'),
      headers: _setHeader(),
      body: productsModelToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateProducts(ProductsModel data) async {
    final response = await http.put(
      Uri.parse(baseUrl + 'products/${data.id}'),
      headers: _setHeader(),
      body: productsModelToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteProducts(String id) async {
    final response = await http.delete(
      Uri.parse(baseUrl + 'products/$id'),
      headers: _setHeader(),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
