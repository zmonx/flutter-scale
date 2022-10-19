// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_scale/components/custom_widget.dart';
import 'package:flutter_scale/models/product_model.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/themes/color.dart';
import 'package:flutter_scale/utils/utility.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final formkey = GlobalKey<FormState>();

  String? productName, productDetail, productBarcode, productPrice, productQty, productImg;

  void onSubmitProduct() async {
    if (formkey.currentState!.validate()) {
      formkey.currentState!.save();

      if (await Utility.getInstance()!.checkNetwork() == "") {
        Utility.getInstance()!.showAlertDialog(
          context,
          "Network Error",
          "Please check internet connection!",
          txtBtn: "OK",
        );
      } else {
        ProductsModel model = ProductsModel(
          productDetail: productDetail.toString(),
          productName: productName.toString(),
          productBarcode: productBarcode.toString(),
          productQty: productQty.toString(),
          productPrice: productPrice.toString(),
          productImage: productImg.toString(),
        );
        var response = await CallApi().createProducts(model);

        if (response) {
          Navigator.pop(context);
        } else {
          Utility.getInstance()!.showAlertDialog(
            context,
            "Error",
            "Can't create product!",
            txtBtn: "OK",
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
        ),
        body: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                SizedBox(
                  width: 250,
                  child: inputFieldwidget(
                    context,
                    Icon(Icons.sell_outlined),
                    "Product name",
                    (onValidate) {
                      if (onValidate!.isEmpty) {
                        return 'Please fill this field';
                      } else {
                        return null;
                      }
                    },
                    (onSaved) {
                      productName = onSaved;
                    },
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: inputFieldwidget(
                    context,
                    Icon(Icons.list),
                    "Product Detail",
                    (onValidate) {
                      if (onValidate!.isEmpty) {
                        return 'Please fill this field';
                      } else {
                        return null;
                      }
                    },
                    (onSaved) {
                      productDetail = onSaved;
                    },
                    keyboardType: TextInputType.multiline,
                    maxline: 5,
                    maxlenght: 250,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: inputFieldwidget(context, Icon(Icons.book), "Product Barcode", (onValidate) {
                    if (onValidate!.isEmpty) {
                      return 'Please fill this field';
                    } else {
                      return null;
                    }
                  }, (onSaved) {
                    productBarcode = onSaved;
                  }, keyboardType: TextInputType.number),
                ),
                SizedBox(
                  width: 250,
                  child: inputFieldwidget(context, Icon(Icons.price_change), "Product Price", (onValidate) {
                    if (onValidate!.isEmpty) {
                      return 'Please fill this field';
                    } else {
                      return null;
                    }
                  }, (onSaved) {
                    productPrice = onSaved;
                  }, keyboardType: TextInputType.numberWithOptions(decimal: true)),
                ),
                SizedBox(
                  width: 250,
                  child: inputFieldwidget(context, Icon(Icons.production_quantity_limits), "Product Qty", (onValidate) {
                    if (onValidate!.isEmpty) {
                      return 'Please fill this field';
                    } else {
                      return null;
                    }
                  }, (onSaved) {
                    productQty = onSaved;
                  }, keyboardType: TextInputType.number),
                ),
                SizedBox(
                  width: 250,
                  child: inputFieldwidget(context, maxlenght: 250, Icon(Icons.image), "Product Image", (onValidate) {
                    if (onValidate!.isEmpty) {
                      return 'Please fill this field';
                    } else {
                      return null;
                    }
                  }, (onSaved) {
                    productImg = onSaved;
                  }, keyboardType: TextInputType.url),
                ),
                SizedBox(
                  width: 250,
                  child: submitBtn(
                    onSubmitProduct,
                    "add product",
                    color: primary_dark,
                    textColor: icons,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
