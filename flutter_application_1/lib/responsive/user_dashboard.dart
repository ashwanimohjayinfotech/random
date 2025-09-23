import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/responsive/message.dart';
import 'package:flutter_application_1/responsive/setting.dart';
import 'package:flutter_application_1/responsive/login_page.dart';

class Userdashboardpage extends StatefulWidget {
  const Userdashboardpage({super.key});

  @override
  State<Userdashboardpage> createState() => _UserdashboardpageState();
}

class _UserdashboardpageState extends State<Userdashboardpage> {
  String selectedPage = "dashboard";

  Widget _getPage(String key) {
    switch (key) {
      case "messages":
        return const MessagesPage();
      case "settings":
        return const SettingsPage();
      case "logout":
        _logoutUser(context); // handle logout
        return _buildDashboardContent();
      case "dashboard":
      default:
        return _buildDashboardContent();
    }
  }

  void _logoutUser(BuildContext context) {
    Future.microtask(() {
      Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
        (route) => false,
      );
    });
  }         

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      appBar: AppBar(
        title: const Text("User Dashboard"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logoutUser(context),
          ),
        ],
      ),
      drawer: isDesktop
          ? null
          : buildMyDrawer(
              (selected) {
                Navigator.pop(context);
                setState(() => selectedPage = selected);
              },
              backgroundColor: Colors.white,
            ),
      body: Row(
        children: [
          if (isDesktop)
            SizedBox(
              width: 250,
              child: buildMyDrawer(
                (selected) {
                  setState(() => selectedPage = selected);
                },
                backgroundColor: Colors.white,
              ),
            ),
          Expanded(child: _getPage(selectedPage)),
        ],
      ),
    );
  }

  /// Your original dashboard content
  Widget _buildDashboardContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Welcome Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Text(
              "Welcome User 👋\nGlad to see you back!",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const SizedBox(height: 20),

          /// Quick Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatCard("Messages", "12", Icons.message),
              _buildStatCard("Tasks", "5", Icons.task),
              _buildStatCard("Notifications", "3", Icons.notifications),
            ],
          ),
          const SizedBox(height: 20),

          /// Recent Activity
          const Text(
            "Recent Activity",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.check_circle, color: Colors.green),
              title: const Text("You completed your profile setup."),
              subtitle: const Text("2 hours ago"),
            ),
          ),
          Card(
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.blue),
              title: const Text("Order #1234 placed successfully."),
              subtitle: const Text("Yesterday"),
            ),
          ),
          Card(
            elevation: 3,
            child: ListTile(
              leading: const Icon(Icons.star, color: Colors.orange),
              title: const Text("You earned a new reward."),
              subtitle: const Text("2 days ago"),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget for stat cards
  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
          child: Column(
            children: [
              Icon(icon, size: 30, color: Colors.blueAccent),
              const SizedBox(height: 10),
              Text(
                value,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(title, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}
