import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:flutter/material.dart';

class RegisterOrLoginPage extends StatefulWidget {
  const RegisterOrLoginPage({super.key});

  @override
  State<RegisterOrLoginPage> createState() => _RegisterOrLoginPageState();
}

class _RegisterOrLoginPageState extends State<RegisterOrLoginPage> {
  bool isShowLoginpage = true;

  void tooglePage() {
    setState(() {
      isShowLoginpage = !isShowLoginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isShowLoginpage) {
      return LogingPage(ontap: tooglePage);
    } else {
      return RegisterPage(ontap: tooglePage);
    }
  }
}
