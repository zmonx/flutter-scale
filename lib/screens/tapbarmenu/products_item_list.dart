// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_scale/models/product_model.dart';
import 'package:flutter_scale/screens/tapbarmenu/product_screen.dart';
import 'package:flutter_scale/screens/updateproduct/update_product_screen.dart';
import 'package:flutter_scale/services/rest_api.dart';

Widget productsItemList(List<ProductsModel> products) {
  return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: products.length,
      itemBuilder: (context, index) {
        ProductsModel product = products[index];
        return Card(
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: FadeInImage(
                              image: NetworkImage(product.productImage),
                              placeholder: AssetImage('assets/images/noimgpic.png'),
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/images/noimgpic.png');
                              },
                              fit: BoxFit.cover,
                            )),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.productName,
                              style: TextStyle(fontSize: 24),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              product.productBarcode,
                              style: TextStyle(fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "฿ ${product.productPrice}",
                              style: TextStyle(fontSize: 18),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/edtproduct',
                            arguments: ScreenArguments(
                              product.id!,
                              product.productName,
                              product.productDetail,
                              product.productBarcode,
                              product.productPrice,
                              product.productQty,
                              product.productImage,
                            ),
                          );
                        },
                        child: Text('แก้ไข'),
                        style: ElevatedButton.styleFrom(),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          return showDialog<void>(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('ยืนยันการลบข้อมูล'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text('รายการนี้จะถูกลบออกอย่างถาวร'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('ไม่ลบ'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('ยืนยัน'),
                                      onPressed: () async {
                                        var res = await CallApi().deleteProducts(products[index].id.toString());
                                        if (res) {
                                          Navigator.pop(context);
                                          refreshKey.currentState!.show();
                                        }
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(),
                        child: Text(
                          'ลบ',
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      });
}
