// lib/constant.dart
import 'package:flutter/material.dart';

var myDefaultColor = Colors.white;

var myAppBar = AppBar(
  iconTheme: IconThemeData(color: Colors.yellow),
  backgroundColor: const Color.fromARGB(223, 201, 199, 199),
  title: Text('My Responsive App', style: TextStyle(
    color: Colors.white
  ),),
);

Drawer buildMyDrawer(Function(String) onItemTap, { Color? backgroundColor}) {
  return Drawer(
    backgroundColor: const Color.fromARGB(197, 229, 232, 233),
    child: Column(
      children: [
        const DrawerHeader(child: Icon(Icons.favorite, size: 48, )),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('D A S H B O A R D'),
          onTap: () => onItemTap('dashboard'),
        ),
        ListTile(
          leading: const Icon(Icons.chat),
          title: const Text('M E S S A G E'),
          onTap: () => onItemTap('messages'),
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('S E T T I N G S'),
          onTap: () => onItemTap('settings'),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('L O G I N'),
          onTap: () => onItemTap('logout'),
        ),
      ],
    ),
  );
}