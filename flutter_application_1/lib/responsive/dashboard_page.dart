import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants.dart';
import 'package:flutter_application_1/responsive/login_page.dart';
import 'package:flutter_application_1/responsive/message.dart';
import 'package:flutter_application_1/responsive/setting.dart';
import 'package:flutter_application_1/responsive/signup.dart';
import 'package:flutter_application_1/services/user_services.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<Dashboard> {
  List users = [];
  bool isLoading = true;
  String selectedPage = "dashboard";

  @override
  void initState() {
    super.initState();
    loadUsers();
  }

  Future<void> loadUsers() async {
    try {
      final data = await UserService.getUsers();
      setState(() {
        users = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  /// Sidebar navigation
  Widget _getPage(String key) {
    switch (key) {
      case "messages":
        return const MessagesPage();
      case "settings":
        return const SettingsPage();
      case "logout":
        return const LoginScreen();
      case "signup":
        return const SignUpScreen();
      case "dashboard":
      default:
        return _buildDashboardContent();
    }
  }

  /// Dashboard content (kept + users list)
  Widget _buildDashboardContent() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          "Welcome back!",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),
        Card(
          child: ListTile(
            leading: const Icon(Icons.analytics, color: Colors.blue),
            title: const Text("Analytics Overview"),
            subtitle: const Text("Track your activity and growth."),
          ),
        ),

        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Users",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ElevatedButton.icon(
              onPressed: () => _showAddUserDialog(),
              icon: const Icon(Icons.add),
              label: const Text("Add User"),
            ),
          ],
        ),
        const SizedBox(height: 15),

        isLoading
            ? const Center(child: CircularProgressIndicator())
            : users.isEmpty
                ? const Text("No users found")
                : Column(
                    children: users.map((user) {
                      return Card(
                        child: ListTile(
                          title: Text(user["name"] ?? ""),
                          subtitle: Text(user["email"] ?? ""),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, color: Colors.blue),
                                onPressed: () =>
                                    _showEditUserDialog(user),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.redAccent),
                                onPressed: () =>
                                    _deleteUser(user["_id"].toString()),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
      ],
    );
  }

  /// Add User
  void _showAddUserDialog() {
    final nameController = TextEditingController();
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Add User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              await UserService.createUser(nameController.text, emailController.text);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              loadUsers();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  /// Edit User
  void _showEditUserDialog(Map user) {
    final nameController = TextEditingController(text: user["name"]);
    final emailController = TextEditingController(text: user["email"]);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Edit User"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: "Email")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () async {
              await UserService.updateUser(user["_id"].toString(), nameController.text, emailController.text);
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
              loadUsers();
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  /// Delete User
  void _deleteUser(String id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this user?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Cancel")),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), child: const Text("Delete")),
        ],
      ),
    );

    if (confirm == true) {
      await UserService.deleteUser(id);
      loadUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth >= 900;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: myAppBar,
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
                    (selected) => setState(() => selectedPage = selected),
                    backgroundColor: Colors.white,
                  ),
                ),
              Expanded(child: _getPage(selectedPage)),
            ],
          ),
        );
      },
    );
  }
}
