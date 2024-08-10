import 'dart:async';
import 'package:chattapp/Login/Login_navigator.dart';
import 'package:chattapp/Login/login_view_model.dart';
import 'package:chattapp/home/home_screen.dart';
import 'package:chattapp/model/my_user.dart';
import 'package:chattapp/provider/user_provider.dart';
import 'package:chattapp/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:chattapp/utils.dart' as Utils;
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login_Screen';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements LoginNavigator {
  String email = '';

  String password = '';
  LoginViewModel viewModel = LoginViewModel();

  @override
  void initState() {
    viewModel.navigator = this;
    super.initState();
  }

  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Stack(
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
            title: Text('Login'),
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
                      child: Text('Login')),
                  SizedBox(
                    height: 18,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(Register_Screen.routeName);
                      },
                      child: Text("Don't Have an account"))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  void validateForm() {
    if (formKey.currentState?.validate() == true) {
      viewModel.loginFirebaseAuth(email, password);
    }
  }

  @override
  void hideLoading() {
    Utils.hideLoading(context);
  }

  @override
  void showLoading() {
    Utils.showLoading(context, "Loading");
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(context, message, "ok", (context) {
      Navigator.pop(context);
    });
  }
@override
  void navigateToHme(MyUser user) {
    var userProvider =Provider.of<UserProvider>(context,listen: false);
    userProvider.user= user;
  Timer(Duration(seconds: 5),(){
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  });
}

}
