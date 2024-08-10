import 'dart:async';

import 'package:chattapp/home/home_screen.dart';
import 'package:chattapp/model/my_user.dart';
import 'package:chattapp/provider/user_provider.dart';
import 'package:chattapp/register/register_navigator.dart';
import 'package:chattapp/register/register_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chattapp/utils.dart ' as Utils;

class Register_Screen extends StatefulWidget {
  static const String routeName = 'Register_Screen';

  @override
  State<Register_Screen> createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen>
    implements RegisterNavigator {
  String firstName = '';

  String lastName = '';

  String userName = '';

  String email = '';

  String password = '';

  var formKey = GlobalKey<FormState>();

  RegisterViewModel viewModel = RegisterViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
          ),
          Image.asset(
            'assets/images/background.png',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text('Create Account'),
              centerTitle: true,
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'First Name'),
                      onChanged: (text) {
                        firstName = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter First Name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Last Name'),
                      onChanged: (text) {
                        lastName = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Last Name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'userName'),
                      onChanged: (text) {
                        userName = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter userName';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: ' Email '),
                      onChanged: (text) {
                        email = text;
                      },
                      validator: (text) {
                        final bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text!);
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter email';
                        }
                        if (!emailValid) {
                          return "please enter valid email";
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'passWord'),
                      onChanged: (text) {
                        password = text;
                      },
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter passWord';
                        }
                        if (text.length < 6) {
                          return 'PassWord must be at least 6 char.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          validateForm();
                        },
                        child: Text('Creat Account'))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> validateForm() async {
    if (formKey.currentState?.validate() == true) {
      viewModel.registerFirebaseauth(
          email, password, firstName, lastName, userName);
    }
  }

  @override
  void hideLoading() {
    Utils.hideLoading(context);
  }

  @override
  void showLoading() {
    Utils.showLoading(context, 'Loading');
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(context, message, 'ok', (context) {
      Navigator.pop(context);
    });
  }

  @override
  void navigateToHme(MyUser user) {
    var userProvider = Provider.of<UserProvider>(context ,listen: false);
    userProvider.user = user;
    Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
    });
  }
}
