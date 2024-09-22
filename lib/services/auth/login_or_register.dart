import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool isloginpage = true;

  void togglepages() {
    setState(() {
      isloginpage = !isloginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isloginpage) {
      return LoginPage(
        onTap: togglepages,
      );
    } else {
      return RegisterPage(
        onTap: togglepages,
      );
    }
  }
}
