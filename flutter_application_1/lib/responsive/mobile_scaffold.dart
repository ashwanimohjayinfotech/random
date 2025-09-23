// lib/responsive/mobile_scaffold.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/responsive/login_page.dart';
import 'package:flutter_application_1/responsive/message.dart';

import 'package:flutter_application_1/responsive/setting.dart';
import 'package:flutter_application_1/responsive/signup.dart';



class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  String selectedPage = 'dashboard';

  Widget _getPage(String key) {
    switch (key) {
      case 'messages':
        return const MessagesPage();
      case 'settings':
        return const SettingsPage();
      case 'logout':
        return  LoginScreen();
      case 'dashboard':
      default:
        return const SignUpScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 231, 229, 223),
      appBar: myAppBar,
      drawer: buildMyDrawer((selected) {
        Navigator.pop(context); 
        setState(() {
          selectedPage = selected;
        });
      }),
      body: _getPage(selectedPage),
    );
  }
}