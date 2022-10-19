// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, empty_constructor_bodies

import 'package:flutter/material.dart';
import 'package:flutter_scale/components/custom_widget.dart';
import 'package:flutter_scale/models/product_model.dart';
import 'package:flutter_scale/screens/tapbarmenu/product_screen.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/themes/color.dart';
import 'package:flutter_scale/utils/utility.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final formkey = GlobalKey<FormState>();

  String? productName, productDetail, productBarcode, productPrice, productQty, productImg;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    onSubmitUpdateProduct() async {
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
            id: args.id,
            productDetail: productDetail.toString(),
            productName: productName.toString(),
            productBarcode: productBarcode.toString(),
            productQty: productQty.toString(),
            productPrice: productPrice.toString(),
            productImage: productImg.toString(),
          );

          var response = await CallApi().updateProducts(model);
          if (response) {
            Navigator.pop(context);
            refreshKey.currentState!.show();
          } else {
            Utility.getInstance()!.showAlertDialog(
              context,
              "Error",
              "Can't update product!",
              txtBtn: "OK",
            );
          }
        }
      }
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Product'),
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
                    initialValue: args.productName,
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
                    initialValue: args.productDetail,
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
                  child: inputFieldwidget(
                    initialValue: args.productBarcode,
                    context,
                    Icon(Icons.book),
                    "Product Barcode",
                    (onValidate) {
                      if (onValidate!.isEmpty) {
                        return 'Please fill this field';
                      } else {
                        return null;
                      }
                    },
                    (onSaved) {
                      productBarcode = onSaved;
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: inputFieldwidget(
                    initialValue: args.productPrice,
                    context,
                    Icon(Icons.price_change),
                    "Product Price",
                    (onValidate) {
                      if (onValidate!.isEmpty) {
                        return 'Please fill this field';
                      } else {
                        return null;
                      }
                    },
                    (onSaved) {
                      productPrice = onSaved;
                    },
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: inputFieldwidget(
                    initialValue: args.productQty,
                    context,
                    Icon(Icons.production_quantity_limits),
                    "Product Qty",
                    (onValidate) {
                      if (onValidate!.isEmpty) {
                        return 'Please fill this field';
                      } else {
                        return null;
                      }
                    },
                    (onSaved) {
                      productQty = onSaved;
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: inputFieldwidget(
                    initialValue: args.productImg,
                    context,
                    maxlenght: 250,
                    Icon(Icons.image),
                    "Product Image",
                    (onValidate) {
                      if (onValidate!.isEmpty) {
                        return 'Please fill this field';
                      } else {
                        return null;
                      }
                    },
                    (onSaved) {
                      productImg = onSaved;
                    },
                    keyboardType: TextInputType.url,
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: submitBtn(
                    onSubmitUpdateProduct,
                    "Update product",
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

class ScreenArguments {
  final String id, productName, productDetail, productBarcode, productPrice, productQty, productImg;

  ScreenArguments(
    this.id,
    this.productName,
    this.productDetail,
    this.productBarcode,
    this.productPrice,
    this.productQty,
    this.productImg,
  );
}
