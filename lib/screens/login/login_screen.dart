// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, use_build_context_synchronously

import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //create key form
  final formkey = GlobalKey<FormState>();

  //var for get value form
  late String _username, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                      "assets/images/image1.png",
                      width: 200,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Username",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please fill username ';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _username = value.toString().trim();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 250,
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please fill password ';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          _password = value.toString().trim();
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: 250,
                      child: ElevatedButton(
                        onPressed: () async {
                          // btn check validation
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            //check connecting internent
                            var networkActive = await Connectivity().checkConnectivity();
                            if (networkActive == ConnectivityResult.none) {
                              AlertDialog alert = AlertDialog(
                                title: Text("Error!"),
                                content: Text("Check your internet!"),
                                actions: [
                                  TextButton(
                                    onPressed: (() => Navigator.pop(context)),
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) => alert,
                              );
                            } else {
                              // call login api
                              var response = await CallApi().loginApi({
                                "username": _username,
                                "password": _password,
                              });
                              var res = jsonDecode(response.body);
                              print(res);
                              if (res['code'].toString() == '200') {
                                //shared_preferences

                                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                //save data to share pref
                                sharedPreferences.setInt("userStep", 1);

                                sharedPreferences.setString("userId", res['data']['id']);
                                sharedPreferences.setString("userName", res['data']['username']);
                                sharedPreferences.setString("fullName", res['data']['fullname']);
                                sharedPreferences.setString("imgProfile", res['data']['img_profile']);
                                sharedPreferences.setString("userStatus", res['data']['status']);

                                Navigator.pushReplacementNamed(context, '/dashboard');
                              } else {
                                AlertDialog alert = AlertDialog(
                                  title: Text("Error!"),
                                  content: Text("Username or Password incorrect"),
                                  actions: [
                                    TextButton(
                                      onPressed: (() => Navigator.pop(context)),
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                                showDialog(barrierDismissible: false, context: context, builder: (context) => alert);
                              }
                            }
                          } else {
                            AlertDialog alert = AlertDialog(
                              title: Text("Error"),
                              content: Text("What the fuck!"),
                              actions: [
                                TextButton(
                                  onPressed: (() => Navigator.pop(context)),
                                  child: Text("OK"),
                                ),
                              ],
                            );
                            showDialog(barrierDismissible: false, context: context, builder: (context) => alert);
                          }
                        },
                        child: Text("Login"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 30,
                      child: Text("Have you account?"),
                    ),
                    SizedBox(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, "/register");
                        },
                        child: Text("Register"),
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
