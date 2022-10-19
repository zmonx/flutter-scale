// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale/components/custom_widget.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/themes/color.dart';
import 'package:flutter_scale/utils/utility.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //create key form
  final formkey = GlobalKey<FormState>();

  //var for get value form
  late String _username, _password, _fullname;

  void onSubmitRegister() async {
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
        var response = await CallApi().registerApi({
          "username": _username,
          "password": _password,
          "fullname": _fullname,
          "status": "1",
        });
        var res = jsonDecode(response.body);
        if (res['status'].toString() == 'success') {
          Utility.getInstance()!.showAlertDialog(
            context,
            "Success",
            "Register Successfuly",
          );
          Timer(Duration(seconds: 2), () {
            Navigator.pushReplacementNamed(context, '/login');
          });
        } else {
          Utility.getInstance()!.showAlertDialog(
            context,
            "Error",
            "Fail to Register",
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
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formkey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Image.asset(
                      "assets/images/image3.png",
                      width: 200,
                    ),
                    SizedBox(
                        width: 250,
                        child: inputFieldwidget(
                          context,
                          Icon(Icons.person),
                          "Full name",
                          (onValidate) {
                            if (onValidate!.isEmpty) {
                              return 'Please fill full name';
                            } else {
                              return null;
                            }
                          },
                          (onSaved) {
                            _fullname = onSaved;
                          },
                        )),
                    SizedBox(
                        width: 250,
                        child: inputFieldwidget(
                          context,
                          Icon(Icons.account_box_outlined),
                          "Username",
                          (onValidate) {
                            if (onValidate!.isEmpty) {
                              return 'Please fill username';
                            } else {
                              return null;
                            }
                          },
                          (onSaved) {
                            _username = onSaved;
                          },
                        )),
                    SizedBox(
                        width: 250,
                        child: inputFieldwidget(
                          obscureText: true,
                          context,
                          Icon(Icons.password_outlined),
                          "Password",
                          (onValidate) {
                            if (onValidate!.isEmpty) {
                              return 'Please fill password';
                            } else {
                              return null;
                            }
                          },
                          (onSaved) {
                            _password = onSaved;
                          },
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: submitBtn(
                        onSubmitRegister,
                        "Register",
                        color: primary_dark,
                        textColor: icons,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 30,
                      child: Text("Already a member"),
                    ),
                    SizedBox(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: Text("Sign In"),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
