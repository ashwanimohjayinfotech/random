import 'package:flutter/material.dart';


class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages")),
      body: ListView.separated(
        itemCount: 5,
        padding: const EdgeInsets.all(12),
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text("User ${index + 1}"),
            subtitle: const Text("Hello! This is a message preview."),
            trailing: Text("2:1$index PM"),
          );
        },
      ),
    );
  }
}
