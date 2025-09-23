// lib/responsive/desktop_scaffold.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/responsive/login_page.dart';
import 'package:flutter_application_1/responsive/message.dart';
import 'package:flutter_application_1/responsive/setting.dart';

import 'package:flutter_application_1/responsive/signup.dart';



class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  String selectedPage = 'dashboard';

  Widget _getPage(String key) {
    switch (key) {
      case 'messages':
        return  MessagesPage();
      case 'settings':
        return  SettingsPage();
      case 'logout':
        return  LoginScreen();
      case 'dashboard':
      default:
         return  SignUpScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: myAppBar,
      body: Row(
        children: [
          
          SizedBox(
            width: 250,
            child: buildMyDrawer((selected) {
              setState(() {
                selectedPage = selected;
              });
            }, backgroundColor: null),
          ),

          
          Expanded(child: _getPage(selectedPage)),
        ],
      ),
    );
  }
}