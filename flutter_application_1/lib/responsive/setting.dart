import 'package:flutter/material.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text("Dark Mode"),
            value: false,
            onChanged: (value) {},
          ),
          const ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("Account"),
            subtitle: Text("Manage your account settings"),
          ),
          const ListTile(
            leading: Icon(Icons.lock),
            title: Text("Privacy"),
            subtitle: Text("Privacy and security settings"),
          ),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
          ),
        ],
      ),
    );
  }
}
